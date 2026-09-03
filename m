Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774F4AC141
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441298; cv=none; b=A2OzNnrxTBkqm6IN9etidqEAf2mnas9kBrJuA5Pq0b/0a6884voVePiYTQCyTz65Je4bmjbz/Q+p6d7xdXhGan5HcL7wWow7LTHBQtuwyLTQgRYuMwB4ZxARfjD51HoRtrATzBML3bO/2D8wQufIIRBEoH8nhSDYDisagtAdiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441298; c=relaxed/simple;
	bh=1A1iOeomxsM0uWHqXo9zCts1DvSZgs9JE0hNM6nIHj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt9d/2nD/1d54pdE8t6NAnfwtlnN6+vMe6R84qxVN9esrp+1UHPIPa2encOpLAzKa35zlIheiK+HQ41tTYh7QD8RkXZ4MSNmtSKwzHluNsDaHNv8x1Sj5lT6epsx1lGb0xKbWMY/nkwsPr+wK4+i2I35WAPvAOe5nFBVNEFE/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbtDQh/s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oN+hjtgo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbtDQh/s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oN+hjtgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788441276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
	b=MbtDQh/s15CbH69FsHJbtOPDnsh1i4W4rL+CtyVyolrwkC6Sv97Un/zMNsUT+50DN6R9wR
	mJBLtt47g0dW+dizF03kPAWtjy+QihJyeHDqFlxoB51HiJviEWMUC4gZEUY6xRABzkf925
	uAa5ISpDmhmfTA9k8g5qZKi0ghcdNS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-rcuwvaOIOA6TSeZwfR9kIQ-1; Thu, 03 Sep 2026 09:14:35 -0400
X-MC-Unique: rcuwvaOIOA6TSeZwfR9kIQ-1
X-Mimecast-MFC-AGG-ID: rcuwvaOIOA6TSeZwfR9kIQ_1788441274
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so7716215e9.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788441274; x=1789046074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
        b=oN+hjtgoh/B+17P4sv0MWcZzbQn2EKrJY3N/V+go9q74rKx6G1WTTCvUPLfBiA9u/6
         u9szaFP3XflbRnEwu30oFpCK0bAqR/dM3RwqksXGKQLDjE52b4GGTKuV08yujn+fW+7x
         3UuaweYrO89GKh1HvRL3IPrF/PWz1RZIXIeLidnzBbqpONFFsPkiTV1RPcc5wjjvUE+H
         H+HwmdYoMpKvjweivIvGW8kLZ/5pIV1+B11M/gJ1QpwF4/prMfrbOK0VvQHwZcSPeomZ
         MhLCdYO19feq9XdsChWghaNi+waGNOYoMkRg8wCli7coMsW3W1ObFInX8QXYwcxZ6nsP
         YGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441274; x=1789046074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
        b=hfT8bVr5G6VIAVCn3cT9y+RoaYuh25HhJDA/iPbf/mBz7vSXjqpz3GENKx5YyDUaJM
         nYidrzcWBqsbJ0mS6/dyM/g+K3sArglDYEOVlT5dQ13CLi0FNxTexP1yNeb5s77Z7Yx7
         RnL6zQq4UFhBc4YUvZdyqzBHuDKtYP87NGTr6loRUmj7yXByOYU5y2afJqwn+qDPCtaS
         fV4P+RxJC6L8QlyNRcdZ7oGxBl6NV7WyeQzGIM+I9gFJ3FYVpff/dDgpmkiLZ9vW17ij
         T2YQEusaqCe9H8YuwdgTN3Derpro6xLeiwBCI1Tq8bl2Hm7EUX5+Qw6fChHdG+CUs15r
         FrPA==
X-Forwarded-Encrypted: i=1; AKwUvByu1Q69lHkWB9zMxDSbpkY2u4Ftiz0zmFEj3+xqB34GFThDOybx/jZA/meS0S9b1VQX6nU=@vger.kernel.org
X-Gm-Message-State: AFuF++leBM70AMUzrIMRwpUWcM6x0Bw+Oy2Br6dn2H95XJJdC3rWxPhm
	hCw1c3mO5oJiBDc4iTuEsGsbK3vtPk0gZq7QmCBtCVtR2SrVnXcZ5W7OMkWafBJNNFhq7AdZuSQ
	oiR1eskreawQ3hNi14AB7MEgsKrgp3TAjCut2WOiRzbVDHaA8cjVccg==
X-Gm-Gg: AYBFou0B6kcgOP6oP0crLdjRrBKUq9rP/D9U9f3g+j7mJJ4XiRL97c+Q9HA5HyEYrnN
	+bDDPAvZZjo4xdsOEejV2vEovm6jTIe4aE5wDYDisDYVYmMGLlM58TS/C1BULDs0joyL5yOIhNa
	fHBxrijNVsw+Rl1557D/+ueTFtxNp0Rk/cstEXwdemVCSX6q7zA/L+fEB5X3tYHzuEq/xdwyE3A
	6IaWw/bT+4wB4NniYYndslTN2NrJvWMkibzfaVs53Yy9xy8qN2nWWKGjRMeCJJBmS52USjcCPfS
	yBJNH37EuF3aWvc2jPXhqqsrzV+vI+z828U//xzWmCKFe8aBLNwSgnIYgiwvCLacECVp15Tr5kE
	O1IJRnbFBmsowm4LRSHBCMD8qkCmAcbroh+XG1mwWzZXPuw==
X-Received: by 2002:a05:600c:8708:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49cf1586a97mr17565315e9.5.1788441274060;
        Thu, 03 Sep 2026 06:14:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8708:b0:49b:4eb6:6ffd with SMTP id 5b1f17b1804b1-49cf1586a97mr17564685e9.5.1788441273448;
        Thu, 03 Sep 2026 06:14:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3b0af8sm72500045e9.0.2026.09.03.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:14:32 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:14:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplvlx7ciHV6Y-nz@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>

On Tue, Sep 01, 2026 at 12:09:21PM +0200, Luigi Leonardi wrote:
>The guest policy carried in the IGVM guest-policy initialization header
>was parsed into QIgvm but never forwarded to the confidential guest
>platform: the previous callback ran at the end of qigvm_process_file,
>after LAUNCH_START had already been issued, so writing the policy had
>no effect.
>
>Add a set_guest_policy callback and invoke it from the guest-policy
>initialization handler, so the policy reaches the platform before
>LAUNCH_START.
>
>The guest policy can also be set on the command line. As it is part of
>the attestation report, silently overriding it would cause attestation
>to fail, so return an error if the command-line value differs from the
>one supplied by the IGVM file.
>
>Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/confidential-guest-support.c |  9 ++++++++
> backends/igvm.c                       |  4 ++++
> target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
> 3 files changed, 52 insertions(+)
>
>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>index a0b36d2da5..c0d15b4a76 100644
>--- a/backends/confidential-guest-support.c
>+++ b/backends/confidential-guest-support.c
>@@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>     return -1;
> }
>
>+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>+                            uint64_t policy, Error **errp)
>+{
>+    error_setg(errp,
>+               "Setting guest policy is not supported for this platform");
>+    return -1;
>+}
>+
> static int set_id_block(void *id_block, uint32_t id_block_size,
>                         void *id_auth, uint32_t id_auth_size,
>                         Error **errp)
>@@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support = check_support;
>     cgsc->set_guest_state = set_guest_state;
>+    cgsc->set_guest_policy = set_guest_policy;
>     cgsc->set_id_block = set_id_block;
>     cgsc->get_mem_map_entry = get_mem_map_entry;
> }
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 6545382546..5131ee7829 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>
>     if (guest->compatibility_mask & ctx->compatibility_mask) {
>         ctx->sev_policy = guest->policy;
>+        if (ctx->cgsc) {
>+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>+                                               guest->policy, errp);
>+        }
>     }
>     return 0;
> }
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index c76cdba8d2..533ea4b54e 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -128,6 +128,8 @@ struct SevCommonState {
>     bool kernel_hashes;
>     uint64_t sev_features;
>     uint64_t supported_sev_features;
>+    /* whether the guest policy was explicitly set on the command line */
>+    bool policy_set;
>
>     /* runtime state */
>     uint8_t api_major;
>@@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>
>+static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>+                                uint64_t policy, Error **errp)
>+{
>+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>+
>+    if (policy_type != GUEST_POLICY_SEV) {
>+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>+                   policy_type);
>+        return -1;
>+    }
>+
>+    if (sev_snp_enabled()) {
>+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>+
>+        if (sev_common->policy_set &&
>+            sev_snp_guest->kvm_start_conf.policy != policy) {
>+            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>+            return -1;
>+        }
>+
>+        sev_snp_guest->kvm_start_conf.policy = policy;
>+    } else {
>+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
>+
>+        if (sev_common->policy_set && sev_guest->policy != policy) {
>+            error_setg(errp, "SEV: policy mismatch between IGVM and CLI");
>+            return -1;
>+        }
>+
>+        sev_guest->policy = policy;

`sev_guest->policy` is u32, should we add a check before this 
assignment?

Stefano

>+    }
>+    return 0;
>+}
>+
> static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
>                             void *id_auth, uint32_t id_auth_size,
>                             Error **errp)
>@@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support = cgs_check_support;
>     cgs->set_guest_state = cgs_set_guest_state;
>     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
>+    cgs->set_guest_policy = cgs_set_guest_policy;
>     cgs->set_id_block = cgs_set_id_block;
>     cgs->can_rebuild_guest_state = true;
>
>@@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
>         return;
>     }
>+    SEV_COMMON(obj)->policy_set = true;
> }
>
> static void
>@@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
>                            errp)) {
>         return;
>     }
>+    SEV_COMMON(obj)->policy_set = true;
> }
>
> static char *
>
>-- 
>2.55.0
>

