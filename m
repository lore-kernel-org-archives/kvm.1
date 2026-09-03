Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D648EBC1
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432429; cv=none; b=pIEWkn4mIpho+NQZpokaMmN/p6mDW/RRC2Zs6C7naiHIYaE2tciUQWKBYlTIVYCbyuiY8Sx3XI+R6awZAUTO77BBAx1UNvepVvBttMs4clHyrPEHJZZOlZCxRh0dLUrq7ehw/+jtohrVLoocuX9rBtNnK+se/bCu30j0SLOk4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432429; c=relaxed/simple;
	bh=xWfHIczEA2mvPlpw7/cO/ft96NQzezvyaliBGWTZt54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLE9dU/l+UJCeWlyvc2RLSSZvzK2Lt547z9sR5/NMvEcxuCJZmgCe4HxmwoxcaIyKuL9eEq2ukdLCTbbh1YSgM1s9K9IeZdk8WM0QeKTEfNPbrR1jYx/G9ptNCdamTU6Bu8kn5ygyvmej0QQ6f8B4LZTaCsYp7/QAMpselX5vQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WT0S713W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o4rl7xi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT0S713W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o4rl7xi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788432426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
	b=WT0S713WGK7UXUA9pO7Yy8MzsUT54BI+j2GTaMoyBgoziPUeM/toIUjWnNw2J4G34jC5P5
	AGvt79uOKP99+VbxLhcjZhMqAWLXB6GZCr6JTxfybmG410QuNyp3fcbyuISp79Y78Ufyfn
	P83n4qQQ1KpkB3yZXc5xvi8N9bm9/wQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-F5lXIetzOXOsVBIzcl_vlg-1; Thu, 03 Sep 2026 06:47:05 -0400
X-MC-Unique: F5lXIetzOXOsVBIzcl_vlg-1
X-Mimecast-MFC-AGG-ID: F5lXIetzOXOsVBIzcl_vlg_1788432424
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-499913d1a79so13847465e9.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788432424; x=1789037224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
        b=o4rl7xi0EEOMHW7MCgkxyzZrSc9cQVYrQDtm/SFyCxwtk11Hlw/OgQH+7OmEWYRnRM
         AQs7ATlJEILtq1vBzxVnQ088rMXxmJIilO2ObgNFwrzk67BBYg3F1HquPzAO1bN7nQXU
         0Ue17QVG+8fdOqtsAVQA1aUBMVHik947sjwMql9QtcB/398/oeMo07BkZA+GMzW2mJO1
         EJ15vhR6N9ZiLxZhefIiut/Kj5mWSdScrkKB3Q9MZTCaJYRcppvE0f+zXdlFD8D3U37P
         S4n3wwXM9njFLn9iLwUh3pcIyMIy4YUHFaKwa0FnxgYwtf7cPZvM9k8IpzSikJZwB1YS
         oE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788432424; x=1789037224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hf8yu5d7GebbmHWi/7eHO3R3u498r/IQfuzDpLs9L7g=;
        b=E2ZlDde9XImxk59/ARpSOXVLby7mLEfOyft98WXNh08wZ0yrUrx0BLk81VraThxz3W
         VrVtFN8z1yC9ICeD75AREKTPXnN8QWQ10NUaWSMF+/LW/Vgh1//tNAQ6f+MYXcTsCmtC
         ya+zEsTex68Ll1BNSLK0YmK5svNUBi+efCkkwZfB9gtIqfVmHVVDCYp3LhnjC7Xa0006
         q/hheBhjvG/GbQVYaJHKSVnCDHzQw2H2PWYDP1bNDz85j8DuVZcWHdZNZ6ZjG15YAOL+
         Whxh//M9wwmD6DkJrlT6w1biMnz1/gID7nd2Fjf6GqQTr2uAibjI+1Idu52jgLwyv+gT
         XvLA==
X-Forwarded-Encrypted: i=1; AKwUvBxCxzwLervbqGlnXvki2VG48+xqZxtDy+V/kF8XcHdsAs34WgdITa7c0MMwfTwKRy6rTHg=@vger.kernel.org
X-Gm-Message-State: AFuF++nt1OXHTahZe0Tf6/UgAZWW2TcQmSLEIZEFpqv+tDm45TtfE7jZ
	e5c1R6Q3EvU1NDuukQg3WxeudlkM/latMsWDN/y38hbYNPRODT2plsa0wuzCKfvxqZ499wIV5V0
	DnbsBV5sguKxu4GPdlgR+SbZU7IdWeebp33Qzi/im8sdstTd+gTPvcA==
X-Gm-Gg: AYBFou1hJ+PtFCzl1KnaaTq7aBCVS/5m3WICAe6fImEOdhGWRc0wc3iKGUW4OPrsYYi
	V37+DCFeROjTeSrR4T7esvb2zpAli3QjbAHO7dJaeY5z0lPYkRK4bkWYmEv4MtdVx+ezjOg8/fL
	+sMch4lcORt6cEkm3Gyi+Bmo5c/vlBefGdOueqFRpnDeoChOKH7XqO2lVw/0uH+t4bZKQ/bbum4
	VBfsplDX0qxr+ozyEIjsCvj/ryXXAzx1X1gfi+9fKaqEgzPRm1E1RcMlyuzFH8KsqObontCkp3H
	p9AuM8yyDAywY04U4snt0bpEsy5/m1dmsSIOLzOV05DqU3DMdm1CjNtqGUGqA/uLmcWGAR9XSwZ
	6ytbkb3Qy5Pj7tMTOJKiMNWccFhgziHxqWeA=
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49ce580d869mr204539315e9.2.1788432423988;
        Thu, 03 Sep 2026 03:47:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49ce580d869mr204538535e9.2.1788432423542;
        Thu, 03 Sep 2026 03:47:03 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d6029sm63445225e9.6.2026.09.03.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:47:02 -0700 (PDT)
Date: Thu, 3 Sep 2026 12:47:00 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <aplPIuIgLYKofjGq@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplMPpjG6X__JZeM@sgarzare-redhat>

On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
>On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
>>The guest policy must be provided at guest launch start: LAUNCH_START for
>>SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
>>specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
>>specification, section 4.3 (Guest Policy).
>>
>>The policy parameter in set_guest_policy was never effective: by the
>>time this callback runs, LAUNCH_START has already been issued for both
>>SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
>>sev_guest->policy has no effect. In practice the only thing this
>>callback actually does is set the ID block and ID auth for SNP's
>>LAUNCH_FINISH, so rename it to set_id_block to reflect its real
>>purpose, remove the unused policy parameter, and drop the non-SNP code
>>path which was entirely dead.
>>
>>This is preliminary work: actually forwarding the guest policy to the
>>platform before LAUNCH_START is added in a later commit.
>
>IIUC the behaviour is the same after this patch, but IMO better to
>clarify.

Yep, will do.

>
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>backends/confidential-guest-support.c       |  12 ++-
>>backends/igvm.c                             |   6 +-
>>include/system/confidential-guest-support.h |  28 ++++---
>>target/i386/sev.c                           | 118 +++++++++++-----------------
>>4 files changed, 67 insertions(+), 97 deletions(-)
>>
>>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>index 156dd15e66..a0b36d2da5 100644
>>--- a/backends/confidential-guest-support.c
>>+++ b/backends/confidential-guest-support.c
>>@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>    return -1;
>>}
>>
>>-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>-                            uint64_t policy,
>>-                            void *policy_data1, uint32_t policy_data1_size,
>>-                            void *policy_data2, uint32_t policy_data2_size,
>>-                            Error **errp)
>>+static int set_id_block(void *id_block, uint32_t id_block_size,
>>+                        void *id_auth, uint32_t id_auth_size,
>>+                        Error **errp)
>>{
>>    error_setg(errp,
>>-               "Setting confidential guest policy is not supported for this platform");
>>+               "Setting ID block is not supported for this platform");
>>    return -1;
>>}
>>
>>@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>    cgsc->check_support = check_support;
>>    cgsc->set_guest_state = set_guest_state;
>>-    cgsc->set_guest_policy = set_guest_policy;
>>+    cgsc->set_id_block = set_id_block;
>>    cgsc->get_mem_map_entry = get_mem_map_entry;
>>}
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index 7b7bdc72b7..85de0d54ec 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>>            id_block_len = sizeof(struct sev_id_block);
>>            id_auth_len = sizeof(struct sev_id_authentication);
>>        }
>>-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, 
>>ctx->sev_policy,
>>-                                          ctx->id_block, id_block_len,
>>-                                          ctx->id_auth, id_auth_len, errp);
>>+
>>+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>>+                                       ctx->id_auth, id_auth_len, errp);
>>    }
>>    return 0;
>>}
>>diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
>>index 5dca717308..6d35ddb97a 100644
>>--- a/include/system/confidential-guest-support.h
>>+++ b/include/system/confidential-guest-support.h
>>@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>>                           uint16_t cpu_index, Error **errp);
>>
>>    /*
>>-     * Set the guest policy. The policy can be used to configure the
>>-     * confidential platform, such as if debug is enabled or not and can contain
>>-     * information about expected launch measurements, signed verification of
>>-     * guest configuration and other platform data.
>>-     *
>>-     * The format of the policy data is specific to each platform. For example,
>>-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
>>-     * ID block and ID authentication in the 'policy_data' parameters. The type
>>-     * of policy data is identified by the 'policy_type' argument.
>>+     * Set the guest policy for the confidential platform. The policy
>>+     * configures properties of the guest, such as whether debug is
>>+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
>>+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
>>+     * so the policy is in effect for launch.
>>     */
>>    int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
>
>I'm confused, this commit says "rename set_guest_policy to set_id_block"
>so why this callback is still here?
>

We will need this callback in a following patch, so I thought that removing
it to then add it again was pointless. If you prefer I can go this
route, or I can specify it in the commit message.

Luigi

