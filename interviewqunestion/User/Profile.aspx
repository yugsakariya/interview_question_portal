<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/User/Site.Master"
    AutoEventWireup="true" CodeBehind="Profile.aspx.cs"
    Inherits="interviewqunestion.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .profile-page {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1rem 3rem;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2.5rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 999px;
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #ffffff;
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
        }

        .profile-title-block h2 {
            margin: 0;
            font-size: 1.875rem;
            font-weight: 700;
            color: #1f2937;
        }

        .profile-title-block p {
            margin: 0.375rem 0 0;
            color: #6b7280;
            font-size: 1rem;
        }

        .card {
            background: #ffffff;
            border-radius: 0.75rem;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e5e7eb;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1), 0 16px 32px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            margin-bottom: 1.75rem;
        }

        .card-header h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-header h3 i {
            color: #3b82f6;
            font-size: 1.125rem;
        }

        .profile-fields {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.25rem;
        }

        .field-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .field-label {
            font-size: 0.875rem;
            font-weight: 600;
            color: #374151;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .field-label i {
            color: #9ca3af;
            font-size: 0.875rem;
            width: 16px;
        }

        .field-value {
            font-size: 1rem;
            color: #1f2937;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            transition: all 0.2s ease;
        }

        .field-value:hover {
            background: #f3f4f6;
            border-color: #d1d5db;
        }

        .badge-role {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 999px;
            background: #eff6ff;
            color: #1e40af;
            border: 1px solid #dbeafe;
            width: fit-content;
        }

        .badge-role i {
            font-size: 1rem;
        }

        /* Two column layout for larger screens */
        @media (min-width: 768px) {
            .profile-fields {
                grid-template-columns: 1fr 1fr;
            }

            .field-group.full-width {
                grid-column: 1 / -1;
            }
        }

        @media (max-width: 767px) {
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .profile-avatar {
                width: 70px;
                height: 70px;
                font-size: 2rem;
            }

            .profile-title-block h2 {
                font-size: 1.5rem;
            }

            .card {
                padding: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .profile-page {
                padding: 1.5rem 0.75rem;
            }

            .card {
                padding: 1.25rem;
            }

            .profile-fields {
                gap: 1rem;
            }
        }
    </style>

    <div class="profile-page">

        <!-- Header -->
        <div class="profile-header">
            <div class="profile-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="profile-title-block">
                <h2>My Profile</h2>
                <p>View and manage your account information</p>
            </div>
        </div>

        <!-- Read-only details -->
        <div class="card">
            <div class="card-header">
                <h3>
                    <i class="fas fa-id-card"></i>
                    Account Details
                </h3>
            </div>

            <div class="profile-fields">
                <div class="field-group">
                    <span class="field-label">
                        <i class="fas fa-user"></i>
                        Full Name
                    </span>
                    <div class="field-value">
                        <asp:Label ID="lblFullName" runat="server"></asp:Label>
                    </div>
                </div>

                <div class="field-group">
                    <span class="field-label">
                        <i class="fas fa-envelope"></i>
                        Email Address
                    </span>
                    <div class="field-value">
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </div>
                </div>

                <div class="field-group">
                    <span class="field-label">
                        <i class="fas fa-at"></i>
                        Username
                    </span>
                    <div class="field-value">
                        <asp:Label ID="lblUsername" runat="server"></asp:Label>
                    </div>
                </div>

                <div class="field-group">
                    <span class="field-label">
                        <i class="fas fa-shield-alt"></i>
                        Role
                    </span>
                    <div class="field-value">
                        <span class="badge-role">
                            <i class="fas fa-user-graduate"></i>
                            <asp:Label ID="lblRole" runat="server"></asp:Label>
                        </span>
                    </div>
                </div>

                <div class="field-group full-width">
                    <span class="field-label">
                        <i class="fas fa-calendar-alt"></i>
                        Member Since
                    </span>
                    <div class="field-value">
                        <asp:Label ID="lblMemberSince" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>