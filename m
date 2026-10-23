Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767976;
	b=u3LhJX1GIxGln8FaLORcrbHG/VPeKrhu4JjX2YCWAW2yvHg4Jb9UfcukRvJgjCwuja9d
	 xB7SIDSExsaGZeDT6sI1Z1HIJAfOoBhsXKkj8/MFPU09Svw+kZmcGHepX6w4pdcJd157K
	 6x81judvtZSXrERX44J2Ad+nNTM4mzoSF1ZH2njv6hwfTgVmEzEc4+EYrV7pY/YCaLakZ
	 R7HggdLId8tGWfUM/+ftZxsT6yrjJkAfMv87YTi6I1HUwKM5ewCMlU4xx3wLJNMvWGSbo
	 +y+hofsJx/PXy6+VfYU7VAoIK8QIeW4o+yOXHi+dxO1WumzwcZWjHFoB6hiJQlVXDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
	b=M6sxRQqZ9x9uB9tA+PYOMQGkHeh4ykPL54IJDd+53c+sfBd9hld0oNfxy28bT5828B+g
	 Y99QFkCSlrgtOIUYsJobL9V7d9G+KqD+wqiWi+mf+vlVSd78hnbNhHce8ISmpzFWc9bar
	 RXgBw6LKYv05V69wSU1URndqFGAuDyKfF0XImOk1D8FgefTcG8MpcDJ0tq6k7KPXRERod
	 c41BhVPEvJyTM0g9G9wqqz++mi2vGbY3bRRFrIlnFCrHfUb/CLwnMw+emWexj8eFCsh0a
	 TbPWxcTuCMnR9AE4nIpxFmHFH5ym+Riv9IXhZQYAAL/VKK9FwFc4hg7s8NJXStLprqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rY9Eunz7;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E1606A32C
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9E1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rY9Eunz7
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so715510b3a.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792767975; x=1793372775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
        b=rY9Eunz7aQZZgNv1E8e5qXPlPd8OfgnrSrMLIR5SR1JMMqv9sK0+qNbBJuaCPBDtCB
         lfXuWThYUbxke1ygOXvSq7T/Wmv7WWwOtN9G/cSda1Ff443UGstMeMZnw85CUeUSElu5
         16Kku1zpsf3kUSE1OFs08w/YEqypxtf6it/UHlR/pABBDD2rTXVv9HylxGjjb94IO0LS
         vuLGe+TqPzSKxKWfKKHGyEBlpIkiwinhqWpQbyr2l72NoZdicmycRtTb46K/Wn1OaPQ/
         D/mg47rapnmB7jRsc3/Bsu/i8F4PKgf/ZyNpb/b4HZ4xMSdLmbl+75lrHgxkTYJdQYcn
         WWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767975; x=1793372775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wz9tOFWt7BhQDze29fB23fRXoLeWs5QHCqP5Z4tBz+E=;
        b=hGrqNvvECT4G6JdOKLLpCJBVPX06Lw5s5zoQffBrE42I/pKzUTqvJE24NmjogPqAqz
         pO66GZD4x88helihxJ4RwQ2alEZb4w8MoG1qqQdj1jxApUislS88StONMy3eVKFr2IyO
         Jzq+WqpKPIQVlGz0PqiCTqr7BoVHlzTyD1amFFSX436w8N8aTkhqlgh3avune4ipCCBL
         SlIIUOCgsfJT3VfAypmzLR4e5AGjzLeLCUDpWzgcWEWRgwqUsYhxjNfUNvWOtxrIs93K
         cPlHROgFqtyAz6sm9Cjgv58i1haZ/5KGTdCf6dCFAKUKKldiRW2LUUTEHQ1iXW2U2GQI
         mWzg==
X-Forwarded-Encrypted: i=1; AKwUvByyfYy7YxlJrHs7TEPihOhAhwuJa2jFCqrLZS0Uhmlz+JP4CcbKSKl1WlL40TXByFvhGas=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHBYcpWzJmOTGyBVbnQQNUCLbWJBkYkSeo+IU8xIcnoxF113mE
	bsWVCPiZDmt5PQlLey37qulDj6Zg67HrTI3qffLLm0B0nu1oWQdz4QYCXvQESf4ZRc49UDu25xA
	LsUbFZg==
X-Received: from pfww6-n2.prod.google.com ([2002:a05:6a00:8886:20b0:890:ac21:250c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e2a:b0:89f:e1e7:e7e8
 with SMTP id d2e1a72fcca58-8a2c5e33c76mr2368910b3a.18.1792767975274; Fri, 23
 Oct 2026 08:06:15 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:06:14 -0700
In-Reply-To: <20261023140506.336663-1-borntraeger@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <50a3ff35-ae53-4372-a53c-c07f1d153627@linux.ibm.com> <20261023140506.336663-1-borntraeger@linux.ibm.com>
Message-ID: <att35ilyLvAA8gM4@google.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 23, 2026, Christian Borntraeger wrote:
> Add a test in which the guest writes to a shmem-backed memslot beyond
> the end of the file.  KVM_RUN must fail with -EFAULT.
> 
> On x86 the guest enables interrupts, and on s390 the test sets up
> pfault, so that KVM could handle the fault with an asynchronous page
> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> retries the access forever, and the test fails after a timeout.
> 
> The test is not built for LoongArch, which handles a failed mapping as
> an MMIO access.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
> I went with Seans name proposal

Aww, bummer.  If you posted a faulty_mcfault_face_test, I would absolutely apply
that and force Paolo to tell me no :-)
