Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3B4B1498
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443761; cv=none; b=HqQmZbpHlw0o9xmF8b1iuXwhYApI1Cy32Z/mmc53NwCygcGAijwSnAelVEDrKbRUDD7zSRV2eDvaY1VNdm8evaWIPib9/CvPKptC7XE+ACJjEXU3Lhm5O7hEpa8gff/nAlQOIVzJKw2+yx0iXk6BZf8frjErotnwZuBh1PSD55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443761; c=relaxed/simple;
	bh=dTjpfYieBtwjVmS1CVHHdFSpax+C0zGZDHuiGGwLJxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whievxz2ZtwutVKumr5lnu3FYLv+AVf20FSw8/HqLxzbli94p02oHGy+W2l0ewVs26w1urF5Z5Ot7B68oOCpbVQOjz97EUREpb6oqLMH8GFDSYiGS+7R8c102YgVqZdGdZfEqGflFHcuUuIYmBv3DbPD2amPyrFDBNL6VG0JpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbpDdtbA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezbuBwsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbpDdtbA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezbuBwsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788443741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
	b=cbpDdtbAHNzcVMbRWuKgjyDCgnv9rHKbW+EUlQGSyniQtw1EAi8IPSMsyAhp+gCj4kIbWK
	HNRHMFRRxqDcqvxVDa5SsE1jkqT03RO2I2Gm9MfplTsFVKnM+DrIiflahWEEtednmgOpY7
	ZPM+pamaNgTbw1Ht6d2GawpNJoRiJw4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-PiflfK9INjai1ypqefijUw-1; Thu, 03 Sep 2026 09:55:40 -0400
X-MC-Unique: PiflfK9INjai1ypqefijUw-1
X-Mimecast-MFC-AGG-ID: PiflfK9INjai1ypqefijUw_1788443739
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482e538ad9fso1749043f8f.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788443739; x=1789048539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
        b=ezbuBwsDkPNiAWjkMV0HCPp202l1mllUrTBz8mSQwLkzMfL/72ECCCKbgIlKWdTeCQ
         9jvNPzZ/x2FoPXHy04FZzmC57wFmsH6nxB0ipEWUeHnEuX3IOivhEjC00RPTcCc4n1+/
         +SF4gZDJL5pt8p/QujzeTyTQ/kWfiEXsLeXgw9o13MWEzo3ZcaaKGu8RPldrCsekXpay
         Xfg3PD2UoN17NufZvBQKbDlauULHOExBQZPlwb40u9ovhG2R6G5+5VF7ryGZyyi3Ccte
         WhqBKuTBwfcEsXdGZrZs7EZEQbMzmKgmAbjgMWDVQNFXRJh3XtmLZjpaWvc0PKO+HDGB
         fEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443739; x=1789048539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LG9wJQZdEFX9IF9VRJWkFSFa8IfSUIjwtb28/dYOTyA=;
        b=SuuMtCkhAFNwp8zJ24yWEN9eeofAmNaZ0bYwnYkdQ0ZQennyaV+AQ016BZDT6klRHY
         4/QUQd96L3ARIRCWAio3btobUilBsPzonVmuotE0+V1F9/KVJ0oozgARbJw8Jq1siIJ+
         Rrm3TVApdhZmryii4zg5yO11jreU5qf89TsphTpVqV6P3lDaTm1eaBdT9cOaPuHKyigz
         YZX7g5qG5KcvNXNFaWnKPiPn7uH7obr40/IdlWm+V1KOFRZSkD5V9tUhXegZedopHGXu
         bao/qS6xFoqrfg5QgjvPkdxObVukJPj7jSpCNFIEY2fgRVUMclyD4TsGv8uTZnBhq/os
         ZzFg==
X-Forwarded-Encrypted: i=1; AKwUvByusHeNvLIFYWTcs+Kg+5vTEw7GTN12Mk5ietLUbUaO5q35mQ6aJUwqRHj+vn/xQWejXNw=@vger.kernel.org
X-Gm-Message-State: AFuF++kWNqI446xGKKbw0GOC8DeoGkTSsJk8nHfbAGqEXR7qdZxjOfEJ
	A7SNsG39ejOivHHhcYuawv7esjP8oPfBLvpDh30sOgL/aIpi/fhb66bpXvSesCsvsMheAdD+8uo
	kGxCi7c4G5W4wPwQxd+elsNeTcqfptkK9QGwIseO5XhHdodA5x0n4YegGMtvpQg==
X-Gm-Gg: AYBFou2KvowFhmVtcDF2mbpt8hihSjash8pyPR6mRFVRNMRaiUsqmj5vt2PAYAoBJ1C
	lgaDmtMW9/eqUmUipLCAqnTx4DELEsIxBmsvba/6Fsi9jNwv+GX74TURCsMuuiWDFN8LirZkvGZ
	jhWxWkCFezc5pYL7WLFiu0+siX2PDdLXMGRgchcKFQoBx6Y4PwBB0it8f0xN1yMgynTUmNVknOT
	I3WlD28UeXFDK7d1W4gk9TpdFkuoAgFmboCwaZiUo4lvvXG0bJ8IpvUFU1mtm+ujC5FtpGvlbu5
	qepfu/o73oB+eY9sybDzi1vFfnfYdxpkWFlUq5T7d4ql2jcdn4HhQ9KnKpYThZlftgIqSKyqwaN
	aP1y1G1QVGilCZZaL2uj9gB4wIYYs4nZFGqZ1xdAd6baneg==
X-Received: by 2002:a05:6000:46d9:b0:482:e2f2:19c1 with SMTP id ffacd0b85a97d-48586028a7dmr774347f8f.2.1788443739236;
        Thu, 03 Sep 2026 06:55:39 -0700 (PDT)
X-Received: by 2002:a05:6000:46d9:b0:482:e2f2:19c1 with SMTP id ffacd0b85a97d-48586028a7dmr774262f8f.2.1788443738736;
        Thu, 03 Sep 2026 06:55:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cf550sm14134925f8f.37.2026.09.03.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:55:37 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:55:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <apl2D4DKmfHohZdF@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
 <aplPIuIgLYKofjGq@leonardi-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplPIuIgLYKofjGq@leonardi-redhat>

On Thu, Sep 03, 2026 at 12:47:00PM +0200, Luigi Leonardi wrote:
>On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
>>On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
>>>The guest policy must be provided at guest launch start: LAUNCH_START for
>>>SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
>>>specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
>>>specification, section 4.3 (Guest Policy).
>>>
>>>The policy parameter in set_guest_policy was never effective: by the
>>>time this callback runs, LAUNCH_START has already been issued for both
>>>SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
>>>sev_guest->policy has no effect. In practice the only thing this
>>>callback actually does is set the ID block and ID auth for SNP's
>>>LAUNCH_FINISH, so rename it to set_id_block to reflect its real
>>>purpose, remove the unused policy parameter, and drop the non-SNP code
>>>path which was entirely dead.
>>>
>>>This is preliminary work: actually forwarding the guest policy to the
>>>platform before LAUNCH_START is added in a later commit.
>>
>>IIUC the behaviour is the same after this patch, but IMO better to
>>clarify.
>
>Yep, will do.
>
>>
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>backends/confidential-guest-support.c       |  12 ++-
>>>backends/igvm.c                             |   6 +-
>>>include/system/confidential-guest-support.h |  28 ++++---
>>>target/i386/sev.c                           | 118 +++++++++++-----------------
>>>4 files changed, 67 insertions(+), 97 deletions(-)
>>>
>>>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>>>index 156dd15e66..a0b36d2da5 100644
>>>--- a/backends/confidential-guest-support.c
>>>+++ b/backends/confidential-guest-support.c
>>>@@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>>>   return -1;
>>>}
>>>
>>>-static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>>>-                            uint64_t policy,
>>>-                            void *policy_data1, uint32_t policy_data1_size,
>>>-                            void *policy_data2, uint32_t policy_data2_size,
>>>-                            Error **errp)
>>>+static int set_id_block(void *id_block, uint32_t id_block_size,
>>>+                        void *id_auth, uint32_t id_auth_size,
>>>+                        Error **errp)
>>>{
>>>   error_setg(errp,
>>>-               "Setting confidential guest policy is not supported for this platform");
>>>+               "Setting ID block is not supported for this platform");
>>>   return -1;
>>>}
>>>
>>>@@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>>>   ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>>>   cgsc->check_support = check_support;
>>>   cgsc->set_guest_state = set_guest_state;
>>>-    cgsc->set_guest_policy = set_guest_policy;
>>>+    cgsc->set_id_block = set_id_block;
>>>   cgsc->get_mem_map_entry = get_mem_map_entry;
>>>}
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index 7b7bdc72b7..85de0d54ec 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>>>           id_block_len = sizeof(struct sev_id_block);
>>>           id_auth_len = sizeof(struct sev_id_authentication);
>>>       }
>>>-        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, 
>>>ctx->sev_policy,
>>>-                                          ctx->id_block, id_block_len,
>>>-                                          ctx->id_auth, id_auth_len, errp);
>>>+
>>>+        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>>>+                                       ctx->id_auth, id_auth_len, errp);
>>>   }
>>>   return 0;
>>>}
>>>diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
>>>index 5dca717308..6d35ddb97a 100644
>>>--- a/include/system/confidential-guest-support.h
>>>+++ b/include/system/confidential-guest-support.h
>>>@@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
>>>                          uint16_t cpu_index, Error **errp);
>>>
>>>   /*
>>>-     * Set the guest policy. The policy can be used to configure the
>>>-     * confidential platform, such as if debug is enabled or not and can contain
>>>-     * information about expected launch measurements, signed verification of
>>>-     * guest configuration and other platform data.
>>>-     *
>>>-     * The format of the policy data is specific to each platform. For example,
>>>-     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
>>>-     * ID block and ID authentication in the 'policy_data' parameters. The type
>>>-     * of policy data is identified by the 'policy_type' argument.
>>>+     * Set the guest policy for the confidential platform. The policy
>>>+     * configures properties of the guest, such as whether debug is
>>>+     * enabled. Its format is platform-specific; for SEV/SEV-ES and
>>>+     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
>>>+     * so the policy is in effect for launch.
>>>    */
>>>   int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
>>
>>I'm confused, this commit says "rename set_guest_policy to set_id_block"
>>so why this callback is still here?
>>
>
>We will need this callback in a following patch, so I thought that removing
>it to then add it again was pointless. If you prefer I can go this
>route, or I can specify it in the commit message.

I see your point about avoiding remove and re-add the callback, but
self-contained commits aren't a matter of preference or taste, they're
a maintainability requirement. A callback declared but unimplemented
across three commits leaves the API in an incomplete state.

Please move the set_guest_policy declaration where it's first used.

Thanks,
Stefano

