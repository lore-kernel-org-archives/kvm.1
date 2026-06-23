Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA01377ED9
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255340; cv=none; b=H9fle2QdOha+ubg+JXkXIoiOkwlRnPJZOHjGRygJud5MdgUnYd5Lx04b/2UP2Hxpq4jA4UWYZ/pMq3KIcMKt6ThoYYiN2WQsISjJ5ntFGOpA5+Sn4USwlWfrt3U0xhjueEyimZJRB8vgeEMJINod3Dr5+QZ2kfdr3mWbGYENMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255340; c=relaxed/simple;
	bh=MwiTLTvWMi5we0wq9H+A4pEK2rQFv7a600iBZ1tbkfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbBNV0wOE/INtz9omGWtA2Xk4lAaQ0vfyEoIM9FtZsmJxGbvI+7B4plVb12minoFlSm+Hvu4A0HYlJDB7mPphPlF+4fOHF+KMHWIgm7oG7JCam4OgIgYHWlVPBky5E8Q3OLiwPJ8H8+kiDq26XjqcYdN9ZC8adge1e7/RVmeeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McIRO0Rx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McIRO0Rx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88fc985a65so165592a12.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782255338; x=1782860138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hT3VCqUm2Ux7vYU+ifVxqJjUxK1YkxRuVhgwv0pUFM=;
        b=McIRO0RxE4Mi1dAmdMTTWPPp9Q0XyRwIgqUi7QgdIbEzQz4qnhf54Ah0kWRx9uzxNw
         PzLzW+f9+yOuMvg+bLsAGQSYUuEeiZe+7d/CoXXeXDRV6jWbqZvWJ4gp1SD6KmORhN+i
         CkjMdfj53Dgn5uv6j94XKMEcQ1udjJiR67ypn7qRyHoNnrLKVAg9k5e26XTuOzmM0uN8
         NxHm4DYdaijrhpv1hK5szHQgdk5gr+TEpu+HwXScaa+QRfQnA8m9EJzMw+CnDUjLJv+q
         lxD0PG9bVfNVnNMs9N5sbxMYk1dy0VhwZLnWWWF5BVWWPJmUkue/daBLe1sxB259YyT2
         HzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782255338; x=1782860138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hT3VCqUm2Ux7vYU+ifVxqJjUxK1YkxRuVhgwv0pUFM=;
        b=X6wOUDSywlGM+28xYYs+FgRaycdL1tGw5cJL53DMoCEtT4dy3K73qgn7rUvIzAphyI
         +yFHbBBJYtjTdXJTbhjwxujz4C9V3FsnYup6Pq38/+XnFYTjvOvohuqjbji00BaxR410
         noEMccxkACRw8MMKBWvKiAvGpdDxQTTOg6teVsEt9gHhoVYggy5TZOnQ4Dbl9PItnGk1
         hYM6OTF1jY2Dw01m9vdTyRH71rCud9n74949DULiuQ+vV1HvnesvuVSzNTngwgq5KBNk
         02bP1scJqKbnxZlJaFhCvTeVzsuo5zyhYDxp2pok+9N0Vhf7XKe6/+0cXDMAjBRZjKPh
         MsUw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ug3IH/sWQTWPolOtJ5XqJqNOQrmhIwukqVFsWZbr7bcxzneCc9kBWKUXVtw9JSh1CBXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwayxjVTWYkC3bIxZ0PpMSvH6j7+PQ9YVsF6P/gRW3CFTXuk3
	5nefjLCs18ofqnVpzoz5hOzSufK0K+bN+xYaCcFKAl63lpE59cRq1xDbp0d7RfCz+jPu+UW9Src
	+PT1eVw==
X-Received: from pgy7.prod.google.com ([2002:a63:1847:0:b0:c85:894e:5b3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:710e:b0:39f:24a5:3065
 with SMTP id adf61e73a8af0-3bd2cea2c50mr789587637.7.1782255338243; Tue, 23
 Jun 2026 15:55:38 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:55:37 -0700
In-Reply-To: <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com> <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com> <ajsCdRhFEw2pcIXx@google.com>
 <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com>
Message-ID: <ajsO6SLATtDsXYsZ@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA
 at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Jethro Beekman <jethro@fortanix.com>
Cc: Jon Lange <jlange@microsoft.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"thomas.lendacky" <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Jethro Beekman wrote:
> On 2026-06-24 00:02, Sean Christopherson wrote:
> >> A UAPI that allows creation of all architecturally-valid enclaves for
> >> purposes of measurement portability was stated as an explicit non-goal. As
> >> this is the only stated purpose of this patch set, it should also not be
> >> accepted.
> > 
> > No, the stated goals (thanks to the follow-up from Jon) are to (a) support VMSA
> > GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and 
> 
> As Jon points out, the VMSA GPA is not architecturally relevant, so any
> enclave can be changed to support a BSP VMSA at 0xFFFFFFFFF000. The only
> reason to "support VMSA GPAs other than KVM's hardcoded, arbitrary
> 0xFFFFFFFFF000" is measurement portability.

Well, that and hardcoding 0xFFFFFFFFF000 is bizarre and confusing, IMO.

> > (b) to play nice with multi-VMPL scenarios in the future.
> 
> It's not clear to me what multi-VMPL scenario Jon is describing that requires
> custom VMSA content/address at launch time other than measurement
> portability. It's currently completely possible for VMPL0 code to set the
> VMPL of a VMSA or create a new VMSA with VMPL>0 at any GPA of their choosing.

Sorry, I phrased that poorly.  It's not about directly playing nice with multi-VMPL
scenarios, it's that if/when multi-VMPL support comes along, the BSP's VMSA for
VMPL0 will likely be the only VMSA that is NOT in guest memory.  And so supporting
an in-guest VMSA for BSP VMPL0 would provide consistency on top of cross-hypervisor
compatilibity, and I place a lot of value on consistency.

FWIW, I loathe the AP_CREATE scheme.  I wish we could go back in time and burn it
with fire.  Unfortunately, we're stuck with it, i.e. we need to deal with the
complexity of in-guest VMSAs regardless of whether or not KVM supports one for
the BSP, at which point we don't gain much by refusing to support "bring your
own VMSA" (so long as the uAPI and implementation are clean and don't add undue
burden).
