Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72338E5E9
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368419; cv=none; b=PzUVjFp70fi+r59ZbLUnFyw3zwc0f6q7arxLlE/SSB7rwU8T+fz3asGSZQaAiNiYrsb5SLZzbca8IohdE96vljCyjtvd4fR042eodREx3HSBgYAXpgBJoTSJQ/ReEE8yJ5Y8jqDvQ1xMfHDunZqR4e71cyeAtrSlbfGVFmOgqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368419; c=relaxed/simple;
	bh=BwUcI927SyLVRlFXerZ4C2KhkdStVKNEijngOS5FYtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dikTIqVl6HSljCArOLm+dIpVhRwsW38RZfNmpKuC0/Yx/VebC5m68Uypf7f3MMIMwni4Ed2OMrJYubogVUngHBSonL3nZw+fxfi7b8kDzYK7kJo91SotpIerCOwvrOgguQGMjRDQfKRcPuN7u6RbFf+tlJWjOLviuIjfVKHsB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3FvDheu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeCB9IEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3FvDheu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeCB9IEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777368415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SElkUbSArWKRvTI8r4YNCpzW999fwj8na5PfWJ0BC/g=;
	b=W3FvDheuTiScigotBS9L8HRsC30ZYPlMt6IaYOrd9cctHIcvxb364EO9dartI9GhHBT1os
	Ff0IiObLZBhzwqjA5Pmr0biirMnlnvKK0trC+D8jps7GHEsWPtHOjXEbBFIn/npWW3xzQx
	ZbLJeIflIZr7GIjId0VvopWQIDIsWA0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-6J9hveDqPVi8Q1R-dEwadA-1; Tue, 28 Apr 2026 05:26:54 -0400
X-MC-Unique: 6J9hveDqPVi8Q1R-dEwadA-1
X-Mimecast-MFC-AGG-ID: 6J9hveDqPVi8Q1R-dEwadA_1777368414
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ed2c173d3bso1810269785a.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777368413; x=1777973213; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SElkUbSArWKRvTI8r4YNCpzW999fwj8na5PfWJ0BC/g=;
        b=IeCB9IEgSOPoyRtZGwMe3F8N5YaQ+IPM1KNmAUx61r5a3t/AYrel43cCQtybm9E6Y7
         uefS2YDdAkS2IPmy2tyZJi7vAC4wxKbi/F/KOQMk+Fi5z1idQTulRBwIAfOU8Gt7uvKL
         T74NISAf2RYrkPrWyp1P5N0SlqR6acGSwHjuGkK3WMKdJD/reZBwbbC/amcGnUOk9kOQ
         fZOxu9gpP73FqtHrkIySDXE02pP9hVEmHo4HIZCuG+57vzcN56X7rnHbkm7kwiaHNdUz
         6gGWMRPpPCemA9zmGUvds6bkZOzwhRPwRMfNSSAsmwfUBRmBdx4KxtdiAd7bhSyRke8X
         7plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368413; x=1777973213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SElkUbSArWKRvTI8r4YNCpzW999fwj8na5PfWJ0BC/g=;
        b=hfGfSzwKQdfPsruiYZcRB87b8viTuWVMQAjd81qoZmPG7ZupbGlCl+d/a531wBxIR3
         QnsWygZVwOu2WMfmbY/GavTMSaWb9M7IqmYUQ/txWkwUGqvTS/dhrFvwEV6DY6daR340
         pL6NLVngxoa5hEeKRx7uc4yC+bFfxUNWO4mVOORWCOyTUTncmVOG6fk/tap5/l87wULR
         wxWVz61aCVNH2VszhpqDKe9LeOFtZXd7IAWGPoytAVbDNudiZ6bwGMgzdTGZMGaIdjKr
         zmI2BcXl/BYBxuKLA+9fw5AtruTpimTjaTYcSYd3E4+nPObn8Ax2vSOSezgyTo002yp/
         P2cA==
X-Forwarded-Encrypted: i=1; AFNElJ8nwtgqRfNM17CVy6mtB5iBgtgsoIs/Q1MB2mbcgB/S+JScLqROdQp9yn+lzQljLYAfkSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UW9Ph6ZwCNfnw0Y1/VMcsri+f6XGC4EvNNGMk+m+QGLgtlcg
	+KVhEl59/21hK6yeH+iyAVC9MxaBEXaaSkA68zvj7jEZr/18SeHmN9/cZtgltv7EV3vYF+pAeuU
	A2ITBsPr+BuQ1ZBufbp8/PJpMeASt9Wc8teCvLCgJvNvtKZOJK6Ko+g==
X-Gm-Gg: AeBDieu8hH5efpZmqIsjCLowNl4qzcJk3sh24YzTBcHY16PnkySmiwTPB9j5r5oH9n7
	f06uMUvf9Catqo1ihIV+vStW2V5doJvUur0Z1rndqM2RBqHJiAGGFtmJCLeOEPmdAnikL4rVg6X
	XUF1BaE3hI6QVDtEXXnOcbz1b6PiPS/y0dmUa1osUi2OnkChCU8d6LaXa5jTHt3K1zodV6FROVO
	serXcABE2Aj0tyckyUQwX/6vJ+YaXVqmvEYEQd093EeaCratFrxnL+nU6KeAaWpWNdPY6GqKIMZ
	w7zsXjccVj6mZGLh54W5CwkYqp0sr+h3sTXTZ9ISKfpVwmLQIS6SATtlDCX2F/oCW9YVcWaQzKY
	A5V6MZ70mAgsRg+yr8i9fXQ4/U8g3
X-Received: by 2002:a05:620a:2a07:b0:8cb:5176:f00 with SMTP id af79cd13be357-8f7d98fe7c8mr276280285a.45.1777368413601;
        Tue, 28 Apr 2026 02:26:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2a07:b0:8cb:5176:f00 with SMTP id af79cd13be357-8f7d98fe7c8mr276261885a.45.1777368409899;
        Tue, 28 Apr 2026 02:26:49 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c81c5605sm142517985a.33.2026.04.28.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:26:49 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>, seanjc@google.com,
 pbonzini@redhat.com
Cc: shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix typo in comment in hyperv_features.c
In-Reply-To: <20260428083037.1926902-1-piotr.zarycki@gmail.com>
References: <20260428083037.1926902-1-piotr.zarycki@gmail.com>
Date: Tue, 28 Apr 2026 11:26:45 +0200
Message-ID: <87v7dbl9ka.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Piotr Zarycki <piotr.zarycki@gmail.com> writes:

> Fix a typo in a comment: 'vailable' -> 'available'.
>
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86/hyperv_features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/hyperv_features.c b/tools/testing/selftests/kvm/x86/hyperv_features.c
> index 130b9ce7e5dd..f943c748f9ff 100644
> --- a/tools/testing/selftests/kvm/x86/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86/hyperv_features.c
> @@ -457,7 +457,7 @@ static void guest_test_msrs_access(void)
>  			msr->fault_expected = true;
>  			break;
>  		case 45:
> -			/* MSR is vailable when CPUID feature bit is set */
> +			/* MSR is available when CPUID feature bit is set */
>  			if (!has_invtsc)
>  				goto next_stage;
>  			vcpu_set_cpuid_feature(vcpu, HV_ACCESS_TSC_INVARIANT);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly

