Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E42C0298
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411438; cv=none; b=QuwTbeht1nNP8JEIl+ZhU9RRwoqUXuuS+PiFS3P/4igl7fr4NsoPNZb1CeNA1F0ib8CCebk9ZcH0/45R6i+HGiUmlJD2tOujkrJv/I+SFBYDg6sTtSjnFOVSFOmaZqyA7hG10vkiulkNwoScSqZlOC0msSRVdq80I9LD8bWOxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411438; c=relaxed/simple;
	bh=vKWkUzz4X0bpy1wS1bHDH15EShZ57erHcsR8b8E2gsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uK6+1zqNyUSS6kZVcc7nfMiS5OJLS6Qwnvs1uup+gci0AO/2zoP3Gvta3y4v0S1ODH8F+KJZIrNQ8ps2OsbSHF3F2YyHxnpowrl2BmnThMBupZ5KOt3VNCofmz8AQM49x44Dlybp7I4H9qKTrWwMDi/SJFDVSCF1jKSPUmbuEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOU0Q2Hm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOU0Q2Hm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7ee3952d6so1400875ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411437; x=1783016237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYqoCrzIGCmqpOtcxPfNb8nePoxNc13ha9iTOF4jwXs=;
        b=hOU0Q2HmkNFGUqkZ3FNonKM8lq8EvJdzNGNL3bkZlBCRDSjgfdJ51xm5dfvl4n2BtJ
         BL56tVCv2n9ftbbsdctmVRful09Op/cniXgpKjPEmlxrkQlV3ibEW9lXTk2ugZWqzhya
         2DiqFrIQjvYcwIB/x0qXItDecYyvSMiTyM6Z/nZVOHVGIsZMpBED6N+20gpi9Z1x3Vpu
         eopdn8oSbzC0IBpoK3JW6b8QMay1sMjErrtU4C3jN24xpWaNGU4lnTPiZMg/mk8pgiLM
         FcjyuaPI5MHgRmzuL6LDRwl2thmA/H7G/YeGQrUBjpzYnO8c4Xlh+k+yf2UETWODPdLQ
         5dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411437; x=1783016237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYqoCrzIGCmqpOtcxPfNb8nePoxNc13ha9iTOF4jwXs=;
        b=cr1Eq+4A8MGwVzgQdwRB6ZUPENmhQT2putxbfH+80T5sb+GQkD9aO79TbFaJdg4mcM
         gJ5ftYwrx6A1QH3ft5xEP6vxQ/bfyWQnh6iYaEdHA8x25d96XfojChBXjKL2TmMdxdhd
         0GiCb3jJy8dv0IewgF0nwQyag5J166V0ZzK3quHSi1e5m9KYGBNktjXOKvEx+pBPMHkg
         VoPEvYplPmr5hFsOgOse01I3fKrMllol956uhD2VptKIEvF0XlrfPZZFRnIRmZjyz7Xi
         njMv5MO8Xy4KKPWe9ylMzp6jtXpL4NdGb2R+5imEBLqCpz24ggW4VfqDKLFnO1Oz2dpO
         fgSA==
X-Forwarded-Encrypted: i=1; AHgh+RqdZ+4NjJUu91rOddMMgN1sjUgZMfWF5pgUW8xlBGkphIXZiPWk+vk6QKzi9HI+A2qX/QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu58hhj1ccULsSgZXyfvFzDCxnCc6heN6umdV8y2BSrpb2KUGr
	4TN25HW/3Zp/2eKMV2OouMvDK9Nnxl+dAvprjv0sGQAHMmlLaEkm7Mg2XlldNOu5wyL6Y8HTBOp
	tLPkMQQ==
X-Received: from pjblx10.prod.google.com ([2002:a17:90b:4b0a:b0:37d:8022:9ef5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5108:b0:36c:e254:4db
 with SMTP id 98e67ed59e1d1-37df9f646f7mr3203405a91.6.1782411436892; Thu, 25
 Jun 2026 11:17:16 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:17:16 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-8-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com> <20260527-kvm-locking-docs-v1-8-4fe8b602ff47@google.com>
Message-ID: <aj1wrF93FLkTNRJQ@google.com>
Subject: Re: [PATCH RFC 08/12] Documentation: KVM: Add example for kvm->srcu
 in relation to mutex/lock
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Add example of where vcpu->mutex and kvm->slots_lock are held while calling
> synchronize_srcu(&kvm->srcu) to concretely show where the synchronization
> primitives overlap.

Sorry, but NAK.  This is too x86-centric, and IMO the risk of the documentation
becoming stale and confusing outweighs any benefits from providing an incomplete
example.  Because like the kvm_usage_count stuff, I know the code in question,
and the example confused me and makes it harder to understand the rule(s).
