Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A884C77C6
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594145; cv=none; b=KzyBEfhEgz+LRR02MxZmGcXsT/tVk4CxgCcE+LNC1uoClINh9uXMWowSBgxm07DetDtyv/lycKvenOhRQS288yCG5YQYlVPo6WwtuLpKpj666Huu3yUODXVbb/Z+++jU2Z4SF1u511J5naPiBuPb7xxrRVUkKDUsC2PnbcwLL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594145; c=relaxed/simple;
	bh=K9ZYKq0YNoYW3fcWvfSnKRK/FCvwVzIOx+OfBeDdh6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqZPzPpl323rBsJIycObdciE5lFY2Wz8q7L0rISzAnhefJS2oLLDP5U5q/qt2a2GUcwHo9mZFLuUugFjYWAbeO9/MYg992nr5jNuXvkOaF/HlFdyn6Mg12RRGzFtq2segLq7lr8HMCzN4j8bcqhIthGBhpbo6gnpcZ4cBByBcgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD9hwUKR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD9hwUKR"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85dcdbe502so811993a12.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594143; x=1781198943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7SNp5SHBgpgOhELDHiwpBP7AwlGI1faTtmzfFHorQs=;
        b=OD9hwUKRhIhnPXSKu4hgt7qbHHqeaTkp2K55khU51peJP+8GNLbDE1Ydbx5Hz8dodW
         51WBVe2Zpf8e2e2mdXQ8YWY78dynAb9uDtun7ovLsYB52wlmZMck76xjge/SG34kxjpz
         Oy4YGBx9BnSUTI23BAydFyVbYF2Bv0OG82lWjOJdjIqNi788WuQTafxAsWaOw9YUrZAJ
         qY9y8M+dh278aNZOZJnanPbGw6msM8aasgS/SpvoFpBnzme1rMW1FFDY2gYvRER9UGyq
         8Snt2f7rBT1kl37clI+mo1i3b3ZYFtWTC3ZPwVujFVsgqQVuI4WnHPc+TId1bctbnWwZ
         y7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594143; x=1781198943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7SNp5SHBgpgOhELDHiwpBP7AwlGI1faTtmzfFHorQs=;
        b=WFaoWoPLNINf9rb2Oh3PwI4a9qNvLyJSitA+jGW4VhmRTs2lW0CnY40qzt4Rez40gw
         s/i6D1J1D4neZ9y8w9f7BSnVQape3em4Y8mG7GyBrx+EoXlqcdFpY4SFexouHFKI4w1R
         b57iLEoBn0CtE8L5xdq3s8SsNqE75KR/lxMa+lg6BcTDUHN7EtsthU0srfKkRXJWwmMp
         iSz2oRghZZ9y9B6QbHiu2wzGKqU0meKBfHrOG79l1ZRZpymFyuLchDdcdfqVh19hX/qr
         5q/+pRTxa1LciwSFqftqYDOu7z62gl2Mw67ZCBC+a/Vimdz9AFnAs/Z+838N2BonmH9q
         KC2w==
X-Forwarded-Encrypted: i=1; AFNElJ8pGTLP3ZEW9myysSzWg+xXhsOyEWwQl1wIROPphdSUxqFQCQ8Tbjf/TkgEYIREHOCfIcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IsVQwxrHGoCbTUwUe97w/ZoM9iGV4dNVZSNPCW3w1CwOClS1
	YzWfSHbOCG5BrQvfmu/HuIqH+odwpIG+yJ37TDvQqSpA0bB/dmJNz4LC2uOgl2RtLCi2pMCxWB2
	o4ldO2g==
X-Received: from pfad23.prod.google.com ([2002:a05:6a00:297:b0:842:37d7:2fef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9094:b0:842:54c1:8e15
 with SMTP id d2e1a72fcca58-84284ecf490mr9177090b3a.29.1780594143231; Thu, 04
 Jun 2026 10:29:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:29:02 -0700
In-Reply-To: <20260604022049.A44EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-21-jrhilke@google.com> <20260604022049.A44EB1F00893@smtp.kernel.org>
Message-ID: <aiG13utvmTJeHbnV@google.com>
Subject: Re: [PATCH v5 20/21] KVM: selftests: Make number of vCPUs
 configurable in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing bounds check on user-supplied `nr_vcpus` allows stack buffer overflows and out-of-bounds global array accesses.
> --
> 
> commit 115e22303a8d11509c805d6bfdcdbd39b670c16d
> Author: David Matlack <dmatlack@google.com>
> 
> KVM: selftests: Make number of vCPUs configurable in IRQ test
> 
> This commit adds a '-v' flag to tools/testing/selftests/kvm/irq_test.c,
> allowing users to configure the number of vCPUs to run in the test.
> 
> > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > index 1d66293b6d0b8..41c50caa928e2 100644
> > --- a/tools/testing/selftests/kvm/irq_test.c
> > +++ b/tools/testing/selftests/kvm/irq_test.c
> [ ... ]
> > @@ -213,6 +214,9 @@ int main(int argc, char **argv)
> >  		case 'n':
> >  			use_nmi = true;
> >  			break;
> > +		case 'v':
> > +			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
> 
> [Severity: Medium]
> Does this code need a bounds check for nr_vcpus against KVM_MAX_VCPUS?

Yep.  It also needs to configure the test to enable x2APIC format and disable
KVM's broadcast quirk, otherwise running with 255+ vCPUs will fail due to KVM
blasting an IRQ to all vCPUs when trying to target vCPU 255.
