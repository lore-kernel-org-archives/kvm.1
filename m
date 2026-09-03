Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC094D90AE
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450831; cv=none; b=u3/2W1uGZYtbgW+IiWjjhSBlxjW5uFYLIh7diB49qBi5qaunfllNEBvFNGkLau5Pfq62X5xfhaU5BTiK5PIx3YKaIt8xrXu6+BDbw6A/Uqw/FviP4a7Axg6QoeH55kkWWIn7h7DKW/R980o+u8cmjNVgLeC8CzMayJHJjIAyLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450831; c=relaxed/simple;
	bh=WqQ/rDOiubhnwwLfISU14vyYD0zVANXYQnl0Gh0lJEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj9jJf+TWxevaTmCce8rxUHFRjHZO0h4yNUorzBcaD+bxn583luNhmnBRs6WOdQZtUknM7CPe+ViT3pMv994x8ZzbynkvfnlD7EN7Ec+WvClTGyIjMK4AQpbTMphc44tOM2eBZL2cRUlNoXr81gGDzRFufbl2LmLxsz8yUqzsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArA0CxID; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+1s0L5z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArA0CxID";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+1s0L5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788450828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
	b=ArA0CxIDHhj14jha4EG8WUKmTDSVZVmerG+0v2v4OMOPOdr29UG0uHVOh5TXviCLYuIwtb
	z+qkcmDEG2YxePxs35pniLiRXOPL4o4ioDM6O19PWG3SNoJxaUcI0/KoQgzl7R0AFGvNro
	Wua3bBNhL/eJEZHMeR7xfHq+jBuQITg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-SZzdMcvCOmCoXDnz13TgOw-1; Thu, 03 Sep 2026 11:53:47 -0400
X-MC-Unique: SZzdMcvCOmCoXDnz13TgOw-1
X-Mimecast-MFC-AGG-ID: SZzdMcvCOmCoXDnz13TgOw_1788450826
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4957287363bso246745e9.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788450826; x=1789055626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
        b=W+1s0L5zTLMhTU6Thdbd6WH+vMSe66MUvvTiA9U/9cnQdq4sEDAkUpL27VjK19Cr07
         9578TomErhcoHD4OnKyFBlnfmFbzHxTQZUo2Jg1Lrt77w658wXZxBikHBBeLS8sJJnKb
         P79GZMmQTj7HG8soZK14JvarILxZUA8Daaf+yCcC8XKw34SReptfmC1Gx967fkrysKWb
         xrzpP7OytOPfq4mOeTQSGBUIoSTYY5PaRr8sackwXe918cfZsOcTVk6jg76wALSx4/Wc
         ACGhGai25EM5OawJw9fr0T5ELdKywcTAW4dCj1hFalwn8YPy1SSOeyrjGHuEvNpSpq3I
         pcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450826; x=1789055626;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64O14QvlKYY21ie3+Vkw2ShSAJTWSPmpeu8FrWkV094=;
        b=gRhj7J2sStDKm+OF2nI8PBDcwXPxM9J2KXsUotAFUz3Aw1wfnmu2m+XdQq6Q+mctIH
         K+eHl9D0jXo7UEaNZ8zTr+6aB3g6Y78+On0Zo1oqEaNehf54eH8dl02KHfkhs03LxpHn
         ifjsSau5RZrO6mFZvRpKQdFU+4lQrxxNbv+aBJ+V36L65z1Rgz/kV5zdm3aG9XrmUypc
         mGYOiVz2zM/eM21B1DbYDgE1SzoBbD1nywl9mrzncs6dBO7fPxxVj5dP3p/je4QZEOFZ
         POII3HrXQso7Q/ycPXV66i5QaKp7lqHwjjmEFaapmXMrVjd+sIHle8d88ncjG64NbpdX
         fEKg==
X-Forwarded-Encrypted: i=1; AKwUvBxkHUU69M1XrVX0ARjNm01zljy7Q3YimTXd2gmWnb1dYmNSbF6Af8yx4tu/1wcBgXCB7nc=@vger.kernel.org
X-Gm-Message-State: AFuF++nxxEv0UvVuAdELKmoGdbey8GGqNBFO4FSeOtlnRpqpiZ7VO883
	pu0kpBdEoPE8tdYE5R07ALYm8fK02Q1fc9WS0AXtzdqH/aFLJN82/71BAWdOLGlaUvl9Pai8yf6
	oPEQ3+/3u/cPYUEzWPc2Iy5TFb3eV+TQgDpUYkS4I9OnBfVivZT+YDQ==
X-Gm-Gg: AYBFou3Pajq7FZeYaXw/59fBPdDiAH6oY3bnmtbAs90H4aL75CNzSYGycyUz+wBXbfS
	XIHSi2Jhhg5jhrrDoA8hOfEAte0DHnc3jiM8xpRpcxqWywCuC3cOhUS+wzq2qQNGf7y+AUprE3/
	2BEm6DabHPwEQVKsvslmja95MRyvEYUjcbDYkb0H+yMA6/AMAO/yoPKQ5vN2Z7pZZnVdMl/sT4H
	TY+mgKneuY1e6TE1nfLqoxf3Vrpl2xiLjXmhu4VM9+0o1Gx4xAM/6ylh+6kyj6uwu7Nudsa11+Q
	gKTG7W4tNDEXyY4ZBC/eUp2io6AgGTAPZWKfH1pFw94i9z5XCm05POQpIiQvqDyE8juPOHTXwTW
	whw6V0ZKmJBGnnuj1flmOM1NoiCnxPTUOvF71P0PRO0aMXw==
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id 5b1f17b1804b1-49cee1d993emr133709365e9.5.1788450826292;
        Thu, 03 Sep 2026 08:53:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id 5b1f17b1804b1-49cee1d993emr133708455e9.5.1788450825824;
        Thu, 03 Sep 2026 08:53:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d587csm87064205e9.4.2026.09.03.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:53:45 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:53:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <apmSUY-7DTUA1tzu@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
 <aplM8ZVCrsjuELHT@sgarzare-redhat>
 <aplyuTrLtvtrT0Kb@leonardi-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aplyuTrLtvtrT0Kb@leonardi-redhat>

On Thu, Sep 03, 2026 at 03:29:35PM +0200, Luigi Leonardi wrote:
>On Thu, Sep 03, 2026 at 02:57:44PM +0200, Stefano Garzarella wrote:
>>On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>>>set_id_block only makes sense when the IGVM file contains an
>>>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>>>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>>>block and ID auth are populated. This avoids a no-op call to
>>>set_id_block when no ID block is present.
>>>
>>>The ID block embeds the guest policy, so the policy must be known by the
>>>time the directive is handled. Process the initialization section (which
>>>carries the GUEST_POLICY header) before the directive section, and
>>>copy ctx->sev_policy into the ID block in the directive handler.
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
>>>1 file changed, 38 insertions(+), 43 deletions(-)
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index 85de0d54ec..6545382546 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>>   ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>>>   memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>>>
>>>+    ctx->id_block->policy = ctx->sev_policy;
>>
>>Is it fine to copy the sev_policy in the id_block in any case?
>>
>>I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM 
>>file, so IIUC sev_policy is 0, but the user set the policy by the 
>>CLI?
>>
>>Maybe this was pre-existing and handled in the next patches.
>
>This is a very good question: id block per snp spec *requires* a policy
>to be set. So can we consider an IGVM file that contains a id block directive
>but not guest policy to be valid? If so, I need to modify the code and read
>the policy from `kvm_start_conf` with a new callback.

Yes, maybe we could throw an error in this case; otherwise, the only 
other option I see is to use the same default we use for the CLI, and at 
this point, reading `kvm_start_conf` might help you keep the default in 
just one place.

Stefano

