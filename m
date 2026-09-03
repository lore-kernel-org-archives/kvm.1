Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30334AF167
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442201; cv=none; b=gFzydfCz+rVPNUvCgH6R2gqohp0aOHB5rNdcz/3TBWv11ao4JbOp81cFh+IAkYBax2Wy4vf+j9K+jLi1w/NgA+fE7vNX59FEB/cxnlNEMmSqEXF47UB8JBDhawnvm9i+6DQaFw/twVxi6+fe5RyAynQo0HoN0U21BQoLk+zpY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442201; c=relaxed/simple;
	bh=7sdWYeYhrRpQza7xfBwoYQX+fxVdsQD1vjkwbtexZ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6+f0u183YmUk7xTxNH0envDQX15Wz/VmphmWSwmfIWk5S9rV2ngiD3mUnT7/HLX9JRp8lsP+yi7XfR6WHjTN28UcoUij4brdPWgYhPy5jHRatOy5mpWmVp5xMCzhfjQ26lQAKnhE/HCHbwwIu9qY4XgmHH7+kTm6n6OY1xSdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2hPBtYh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUYeqMcs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2hPBtYh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUYeqMcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788442184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
	b=B2hPBtYhzge6i1UOUEf8oM76/igWh5Sm4uCIryFkbZ9fAxrdQH1O8AHzRfTsKPjkc8tMtY
	tY90P7iY5zpJSkQHYDcMogwtANKXwuuNyoRGLANXjoisae3qf3mOf1R7PD36IPLR/rsgtA
	1MO0In50tfZwV7nVV7aAzapWorvwYqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-AjDhp74bPnKdrq2L65DehA-1; Thu, 03 Sep 2026 09:29:40 -0400
X-MC-Unique: AjDhp74bPnKdrq2L65DehA-1
X-Mimecast-MFC-AGG-ID: AjDhp74bPnKdrq2L65DehA_1788442180
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so25714145e9.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788442180; x=1789046980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
        b=GUYeqMcs2miMuDnyTAkkI2p++AikAD69C54Qc/+mCj/jHVbj2Mf1Eolv+up789frGb
         VfQfO3EollEpgV8aHTWXVNa3OH2IYAe5zqbg8jFoW7Dgf/iVgJBgJlXJAL9KxWQGFuJ8
         duBb/7qi6EMmuludzgRKMkGf43+16rWaGyjGnld1IxBvlyQjJ5tMKUr+SqsuyMCD/sJl
         4zEoPKDmG+lK0ZX2OyE8ctIpGJ615DWeZzLNrHAEpytbU4jVfjmLi87Ro78MMSCjv8VZ
         o1GMkaMYSW1zjWV73FPFHkbrpBtjd9GrqHijGdXY+HU6cuxngPjiV7CyGGy26sVueTFe
         TCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442180; x=1789046980;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ESVT2yLRXtfbaK4REXN7flcj25MixY+4PT66/UtEXI=;
        b=ntcERhmv0B02rgJkLoqagYfNFXVsoxOQZTViXcVtIhE93kf9BrDrfCLusSoTipmGwM
         xNTJGIs5Rvc2+nUjAhVbcMaTGitzPp4j1ZJVgSPcdNn4dCmc1wPfYCPBPxeQoqD0dVUa
         AhbWstAeE//0sGKGqDZ5pHF0EfM+Qih5wDbiFuUdWLPXp7JfjJDbGAYzCAiFO3LjNjQw
         8V3583uogCIH/6+b1GSAZJtHaWjKEJE68id9TdHMtlrXR1UKiFc9sE7sS2iilDyJ0OyD
         PdpxE7Yq26QcoEv9W8Yh4X+sARvGKgBnXlcibVp8+Wml+PMgMT2lGKWrGdM+7AwkGDbH
         WQmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbGl/YLqtkKL3AjWSgUueclKwDIjQuy0VF27HyBSlTK9V/fLPC5Kx4amfNX0a4Rkkwogw=@vger.kernel.org
X-Gm-Message-State: AFuF++lypXxuTiAL35u1uclqyVvwUUE3y7dYt0FpQ2FPcD3IyanyqNes
	CLhblbjbjVl6vAN4e/CBe52ytVog2EIwkOHBG+6yaPjXmJslD70m5i3Uf9yEgj0eo6IfM3pPD6J
	TQTZiqIOw6cW7O+hHpJjOcLauArdQ/EDixetHyh9Gxz0DVDzq8Z4fsw==
X-Gm-Gg: AYBFou3EyDnlAZ4YriCCLgMDz3DdmJRApdCGVvn931AZNHuYdgGH5nzTmmL3irrLuWu
	34wkpK/hncqmZA+qXiTRbFzZBUPTlgg9BEqMZRf1E7ZAedRbfQbpnV/97zIpeklWcbI87CE/YWG
	zFfp+sWma9I2QEaUs/2aKBXCwV+PgwuOokazi7f3s7au+2aBzVzwuyDbk99Hw6iCEw4BHnZcG5M
	E7LVmlIibIy6pG6cCjT0lwcS0+3+0rOEFqxOEgKGt+YPJ96vVLhSDjhABmmb0KiOZp1u5rJt7b5
	GRtSU837vUHEuHlBlkwVvwYaVQasjfaqzgMNs/dCuC/JzNzwHTOuhG6azPUC9SlsBcICJ0yD/in
	KG8pNS7BARX7WVtJeO8q3MS+yZxrkDtFoh20=
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49ceb160bb1mr127551835e9.3.1788442179758;
        Thu, 03 Sep 2026 06:29:39 -0700 (PDT)
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49ceb160bb1mr127550925e9.3.1788442179324;
        Thu, 03 Sep 2026 06:29:39 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm72286385e9.4.2026.09.03.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:29:38 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:29:35 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <aplyuTrLtvtrT0Kb@leonardi-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
 <aplM8ZVCrsjuELHT@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplM8ZVCrsjuELHT@sgarzare-redhat>

On Thu, Sep 03, 2026 at 02:57:44PM +0200, Stefano Garzarella wrote:
>On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>>set_id_block only makes sense when the IGVM file contains an
>>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>>block and ID auth are populated. This avoids a no-op call to
>>set_id_block when no ID block is present.
>>
>>The ID block embeds the guest policy, so the policy must be known by the
>>time the directive is handled. Process the initialization section (which
>>carries the GUEST_POLICY header) before the directive section, and
>>copy ctx->sev_policy into the ID block in the directive handler.
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
>>1 file changed, 38 insertions(+), 43 deletions(-)
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index 85de0d54ec..6545382546 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>    ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>>    memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>>
>>+    ctx->id_block->policy = ctx->sev_policy;
>
>Is it fine to copy the sev_policy in the id_block in any case?
>
>I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM file, 
>so IIUC sev_policy is 0, but the user set the policy by the CLI?
>
>Maybe this was pre-existing and handled in the next patches.

This is a very good question: id block per snp spec *requires* a policy
to be set. So can we consider an IGVM file that contains a id block directive
but not guest policy to be valid? If so, I need to modify the code and read
the policy from `kvm_start_conf` with a new callback.

Luigi

