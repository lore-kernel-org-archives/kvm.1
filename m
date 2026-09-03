Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EFF5478D
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425268; cv=none; b=ig38ytckBf0NIgnrJOPwJ0/LlhPZPYhUkx6CTPBOhSTnBfLMqa9DDSG/hD4qo4k2hkltg0TB9I7t0hj4OF/dMFZ+SxiCG3Tn5vx6TKGySYRnGg0VHhoXkxwRN802xjE6YpDQVDsBaAK7dStzhL3IW19r7HgGbMHRkUCAfYc7KDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425268; c=relaxed/simple;
	bh=1eRp00v3UV9RHjy+hCJDH+kK2PL5urUorQ5ONkuqt1I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pxAca6BqqSLBFNbOatEKAApPKDz6/qQ6CiOE3uYRJ98wj6Y0Kwgcs6Ua1Z85G1VtuCp4eVW4Ag7AxADGlkJ789yvSjekE25RCU5vD8HM5lusoYpz1b0Q1DSYs2j6ltHNuaA9BavWtE6vigcjYLTvxNETDSOejWZEh1xar1rax9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1x1jaOu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tw41cZ8h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1x1jaOu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tw41cZ8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788425265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
	b=I1x1jaOuKwUszXaRrdVch/1PSWt0I/+gJX/PKPsWRN9VmJrfA1glgx9Gyor4Cnk5ydcYie
	iJfvFw6/5pE0X2BuhJXNMTVoFIyA9H9k0wgeeVQh/ZOGljv9vKhhZauCqCRy6LDYFv82WU
	SMGjxvPte4udds+63i7tB0AFOVzQZfQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-0HGRVIUbMkOFy3dFU9fBzg-1; Thu, 03 Sep 2026 04:47:44 -0400
X-MC-Unique: 0HGRVIUbMkOFy3dFU9fBzg-1
X-Mimecast-MFC-AGG-ID: 0HGRVIUbMkOFy3dFU9fBzg_1788425263
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so4509383a91.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788425263; x=1789030063; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
        b=tw41cZ8h5bH36lBxwWpxq566UQQa4F6wGwhI/+Rs8dEQVy95wbRtCSFznfHk4Oq46P
         kAN7vdogvV+FuYZN4ohcvTotz/DYnyCXd3qRwqT1yHttJvR38321loluCyMIwJ38AinJ
         2UWFgN9d5KZtW6RGo0hyWaTt2SIZTsGa8HmlA84vbQIlFW9l3USJIBFlT/nwEGI9JEzo
         2pRDCf/QOnH8lYhxAhKoImOgkQ7oNWaeV8dLT8CIV75SOe1EvT9PRRmK5sieUY7aZqqG
         EoWxCLn+0D/616eZZVzOq9Wpn1wi0LfmG6Qf9XmFjJDey3lw3NqTU7Bu7o9x6j0eGAHE
         8NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425263; x=1789030063;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOajMmLybDCFGEcp+rfbPxZy2hNP+K9/stcnpik2+m0=;
        b=jAuz/z2xcz7Fy4kU3MNgA59fpextKbJ94JhiT/c3+bpbxsz10KnxZCktsznbqEPVPI
         ghsVz0On8ELPExoeGek9MQFqHZQZiXDvz8WqYtYBcqGkqVK9/vlCPwtcH53Izvaw08aq
         kSSiQPFigBGnr1MHutn7NBhgYUSMNyW4VZyNOzPcRu5KeUeuEd/wmnzUKieM9j9NMLAQ
         O8u9C+Yi4FRnvF7qxhzkJbkaYbtJe7GIt3V3H4al3TYZHOIxZMOgp6R4wbmbHg/JlqGS
         nKfxVVSIA1VFEN8OWosKdxGF+jeySaDVurJ8tqHvKzVtf4gaaV+NgdN0rdVIAQ9n/uLb
         +O+g==
X-Forwarded-Encrypted: i=1; AKwUvBwLm7pLSFb4LlcD3MUs8XhftfGykX5dDIiVb6ns7tQ2yXEkcBY14qYOyi9DxE7Wzi/hkAA=@vger.kernel.org
X-Gm-Message-State: AFuF++kAQwqSiYIEbGsvxTBuBjJzbKXI4QBxMWqrZ0lUHWtMUwzaNg3S
	uA3JAPUoG9i8SNxWV3+R6u8WiJ2TtUUel/60HAVtgD6iyqh8Y77oeYjbyekljImH5BWSu3bVq7Z
	s2Gp9909F//1XVEMIWl1iiGYXevHs7Y7ILMbSwAiH5NKkljTsQa4iZP2tJGlZ3A==
X-Gm-Gg: AYBFou1KOoWqsaY6SoKRBloaakX2NBnmAHAWDEpmnzOVRXk2im/O5zyqdrKmVzrfNXI
	0Mjhx0yhYMq6kPUSLYJzLBPKrvw2XOhLTpbDFIJpsqVDcUZecg1tFEJI8YTQtTy6PLEO3GjRFVh
	Vai8XjhJ5WbUvWuxZZW6EmuouzK51K3AJqJSMnESOiSrdAcswa4xksyKLSLO21T9RUqL6dMFsQE
	rwLY1+xXuIk9O//JsN0jxr7JMBO3S0k0j7vN7gpW2oGpSQz0jcP68iYRdW7sfyuCRTU99np51GM
	H7cP4k/a5Pb3E7wCxdHFg97RLXu5BnIE8kPaWPVjJVst9qXfIM0LNnDRgHE35K6wJVVn3DZKOFg
	ZJHwP6jQ5I98OtVPBHyQTfalrtuKl8h48U+KGaSRIj4kUcQRBWcvyxOY=
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39aedbfe60amr17561142a91.0.1788425262592;
        Thu, 03 Sep 2026 01:47:42 -0700 (PDT)
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39aedbfe60amr17561067a91.0.1788425261959;
        Thu, 03 Sep 2026 01:47:41 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:47:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:17:28 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7F97AAC-1ABD-4AD6-9793-2DBB6B5E4C2C@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The guest policy must be provided at guest launch start: LAUNCH_START =
for
> SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
> specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
> specification, section 4.3 (Guest Policy).
>=20
> The policy parameter in set_guest_policy was never effective: by the
> time this callback runs, LAUNCH_START has already been issued for both
> SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
> sev_guest->policy has no effect. In practice the only thing this
> callback actually does is set the ID block and ID auth for SNP's
> LAUNCH_FINISH, so rename it to set_id_block to reflect its real
> purpose, remove the unused policy parameter, and drop the non-SNP code
> path which was entirely dead.
>=20
> This is preliminary work: actually forwarding the guest policy to the
> platform before LAUNCH_START is added in a later commit.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/confidential-guest-support.c       |  12 ++-
> backends/igvm.c                             |   6 +-
> include/system/confidential-guest-support.h |  28 ++++---
> target/i386/sev.c                           | 118 =
+++++++++++-----------------
> 4 files changed, 67 insertions(+), 97 deletions(-)
>=20
> diff --git a/backends/confidential-guest-support.c =
b/backends/confidential-guest-support.c
> index 156dd15e66..a0b36d2da5 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t =
*ptr, uint64_t len,
>     return -1;
> }
>=20
> -static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> -                            uint64_t policy,
> -                            void *policy_data1, uint32_t =
policy_data1_size,
> -                            void *policy_data2, uint32_t =
policy_data2_size,
> -                            Error **errp)
> +static int set_id_block(void *id_block, uint32_t id_block_size,
> +                        void *id_auth, uint32_t id_auth_size,
> +                        Error **errp)
> {
>     error_setg(errp,
> -               "Setting confidential guest policy is not supported =
for this platform");
> +               "Setting ID block is not supported for this =
platform");
>     return -1;
> }
>=20
> @@ -64,7 +62,7 @@ static void =
confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc =3D =
CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support =3D check_support;
>     cgsc->set_guest_state =3D set_guest_state;
> -    cgsc->set_guest_policy =3D set_guest_policy;
> +    cgsc->set_id_block =3D set_id_block;
>     cgsc->get_mem_map_entry =3D get_mem_map_entry;
> }
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 7b7bdc72b7..85de0d54ec 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error =
**errp)
>             id_block_len =3D sizeof(struct sev_id_block);
>             id_auth_len =3D sizeof(struct sev_id_authentication);
>         }
> -        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, =
ctx->sev_policy,
> -                                          ctx->id_block, =
id_block_len,
> -                                          ctx->id_auth, id_auth_len, =
errp);
> +
> +        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
> +                                       ctx->id_auth, id_auth_len, =
errp);
>     }
>     return 0;
> }
> diff --git a/include/system/confidential-guest-support.h =
b/include/system/confidential-guest-support.h
> index 5dca717308..6d35ddb97a 100644
> --- a/include/system/confidential-guest-support.h
> +++ b/include/system/confidential-guest-support.h
> @@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>                            uint16_t cpu_index, Error **errp);
>=20
>     /*
> -     * Set the guest policy. The policy can be used to configure the
> -     * confidential platform, such as if debug is enabled or not and =
can contain
> -     * information about expected launch measurements, signed =
verification of
> -     * guest configuration and other platform data.
> -     *
> -     * The format of the policy data is specific to each platform. =
For example,
> -     * SEV-SNP uses a policy bitfield in the 'policy' argument and =
provides an
> -     * ID block and ID authentication in the 'policy_data' =
parameters. The type
> -     * of policy data is identified by the 'policy_type' argument.
> +     * Set the guest policy for the confidential platform. The policy
> +     * configures properties of the guest, such as whether debug is
> +     * enabled. Its format is platform-specific; for SEV/SEV-ES and
> +     * SEV-SNP it is a policy bitfield. Must be called before =
LAUNCH_START
> +     * so the policy is in effect for launch.
>      */
>     int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
> -                            uint64_t policy,
> -                            void *policy_data1, uint32_t =
policy_data1_size,
> -                            void *policy_data2, uint32_t =
policy_data2_size,
> -                            Error **errp);
> +                            uint64_t policy, Error **errp);
> +
> +    /*
> +     * Set the SEV-SNP ID block and ID authentication block. These =
are
> +     * passed to SNP_LAUNCH_FINISH to provide signed verification of =
the
> +     * guest configuration.
> +     */
> +    int (*set_id_block)(void *id_block, uint32_t id_block_size,
> +                        void *id_auth, uint32_t id_auth_size,
> +                        Error **errp);
>=20
>     /*
>      * Iterate the system memory map, getting the entry with the given =
index
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 4d875d10ff..465415c535 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2723,10 +2723,9 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>=20
> -static int cgs_set_guest_policy(ConfidentialGuestPolicyType =
policy_type,
> -                                uint64_t policy, void *policy_data1,
> -                                uint32_t policy_data1_size, void =
*policy_data2,
> -                                uint32_t policy_data2_size, Error =
**errp)
> +static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
> +                            void *id_auth, uint32_t id_auth_size,
> +                            Error **errp)
> {
>     SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>     if (sev_common->state =3D=3D SEV_STATE_UNINIT) {
> @@ -2734,86 +2733,57 @@ static int =
cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>         return 0;
>     }
>=20
> -    if (policy_type !=3D GUEST_POLICY_SEV) {
> -        error_setg(errp, "SEV: Invalid guest policy type provided for =
SEV: %d",
> -                   policy_type);
> +    if (!sev_snp_enabled()) {
> +        error_setg(errp, "SEV: ID block is only supported for =
SEV-SNP");
>         return -1;
>     }
> -    /*
> -     * SEV-SNP handles policy differently. The policy flags are =
defined in
> -     * kvm_start_conf.policy and an ID block and ID auth can be =
provided.
> -     */
> -    if (sev_snp_enabled()) {
> -        SevSnpGuestState *sev_snp_guest =3D
> -            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> -        struct kvm_sev_snp_launch_finish *finish =3D
> -            &sev_snp_guest->kvm_finish_conf;
>=20
> -        /*
> -         * The policy consists of flags in 'policy' and optionally an =
ID block
> -         * and ID auth in policy_data1 and policy_data2 respectively. =
The ID
> -         * block and auth are optional so clear any previous ID block =
and auth
> -         * and set them if provided, but always set the policy flags.
> -         */
> -        g_free(sev_snp_guest->id_block);
> -        g_free((guchar *)finish->id_block_uaddr);
> -        g_free(sev_snp_guest->id_auth);
> -        g_free((guchar *)finish->id_auth_uaddr);
> -        sev_snp_guest->id_block =3D NULL;
> -        finish->id_block_uaddr =3D 0;
> -        sev_snp_guest->id_auth =3D NULL;
> -        finish->id_auth_uaddr =3D 0;
> -
> -        if (policy_data1_size > 0) {
> -            struct sev_snp_id_authentication *id_auth =3D
> -                (struct sev_snp_id_authentication *)policy_data2;
> -
> -            if (policy_data1_size !=3D KVM_SEV_SNP_ID_BLOCK_SIZE) {
> -                error_setg(errp, "SEV: Invalid SEV-SNP ID block: =
incorrect size");
> -                return -1;
> -            }
> -            if (policy_data2_size !=3D KVM_SEV_SNP_ID_AUTH_SIZE) {
> -                error_setg(errp,
> -                           "SEV: Invalid SEV-SNP ID auth block: =
incorrect size");
> -                return -1;
> -            }
> -            assert(policy_data1 !=3D NULL);
> -            assert(policy_data2 !=3D NULL);
> +    SevSnpGuestState *sev_snp_guest =3D
> +        SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +    struct kvm_sev_snp_launch_finish *finish =3D
> +        &sev_snp_guest->kvm_finish_conf;
>=20
> -            finish->id_block_uaddr =3D
> -                (__u64)g_memdup2(policy_data1, =
KVM_SEV_SNP_ID_BLOCK_SIZE);
> -            finish->id_auth_uaddr =3D
> -                (__u64)g_memdup2(policy_data2, =
KVM_SEV_SNP_ID_AUTH_SIZE);
> +    g_free(sev_snp_guest->id_block);
> +    g_free((guchar *)finish->id_block_uaddr);
> +    g_free(sev_snp_guest->id_auth);
> +    g_free((guchar *)finish->id_auth_uaddr);
> +    sev_snp_guest->id_block =3D NULL;
> +    finish->id_block_uaddr =3D 0;
> +    sev_snp_guest->id_auth =3D NULL;
> +    finish->id_auth_uaddr =3D 0;
>=20
> -            /*
> -             * Check if an author key has been provided and use that =
to flag
> -             * whether the author key is enabled. The first of the =
author key
> -             * must be non-zero to indicate the key type, which will =
currently
> -             * always be 2.
> -             */
> -            sev_snp_guest->kvm_finish_conf.auth_key_en =3D
> -                id_auth->author_key[0] ? 1 : 0;
> -            finish->id_block_en =3D 1;
> -        }
> +    if (id_block_size > 0) {
> +        struct sev_snp_id_authentication *auth =3D
> +            (struct sev_snp_id_authentication *)id_auth;
>=20
> -        /* do not reset existing policy if policy was not set in IGVM =
 */
> -        if (policy !=3D 0) {
> -            sev_snp_guest->kvm_start_conf.policy =3D policy;
> +        if (id_block_size !=3D KVM_SEV_SNP_ID_BLOCK_SIZE) {
> +            error_setg(errp, "SEV: Invalid SEV-SNP ID block: =
incorrect size");
> +            return -1;
>         }
> -    } else {
> -        SevGuestState *sev_guest =3D =
SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> -        /* Only the policy flags are supported for SEV and SEV-ES */
> -        if ((policy_data1_size > 0) || (policy_data2_size > 0) || =
!sev_guest) {
> -            error_setg(errp, "SEV: An ID block/ID auth block has been =
provided "
> -                             "but SEV-SNP is not enabled");
> +        if (id_auth_size !=3D KVM_SEV_SNP_ID_AUTH_SIZE) {
> +            error_setg(errp,
> +                       "SEV: Invalid SEV-SNP ID auth block: incorrect =
size");
>             return -1;
>         }
> +        assert(id_block !=3D NULL);
> +        assert(id_auth !=3D NULL);
>=20
> -        /* do not reset existing policy if policy was not set in IGVM =
 */
> -        if (policy !=3D 0) {
> -            sev_guest->policy =3D policy;
> -        }
> +        finish->id_block_uaddr =3D
> +            (__u64)g_memdup2(id_block, KVM_SEV_SNP_ID_BLOCK_SIZE);
> +        finish->id_auth_uaddr =3D
> +            (__u64)g_memdup2(id_auth, KVM_SEV_SNP_ID_AUTH_SIZE);
> +
> +        /*
> +         * Check if an author key has been provided and use that to =
flag
> +         * whether the author key is enabled. The first of the author =
key
> +         * must be non-zero to indicate the key type, which will =
currently
> +         * always be 2.
> +         */
> +        sev_snp_guest->kvm_finish_conf.auth_key_en =3D
> +            auth->author_key[0] ? 1 : 0;
> +        finish->id_block_en =3D 1;
>     }
> +
>     return 0;
> }
>=20
> @@ -2878,7 +2848,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support =3D cgs_check_support;
>     cgs->set_guest_state =3D cgs_set_guest_state;
>     cgs->get_mem_map_entry =3D cgs_get_mem_map_entry;
> -    cgs->set_guest_policy =3D cgs_set_guest_policy;
> +    cgs->set_id_block =3D cgs_set_id_block;
>     cgs->can_rebuild_guest_state =3D true;
>=20
>     QTAILQ_INIT(&sev_common->launch_vmsa);
>=20
> --=20
> 2.55.0
>=20

