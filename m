Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73F125AA
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418609; cv=none; b=f3preYm5d31jOxWV2A68imz+cGiy2ySSVMG00xjZg2pCTQny++HLBdX9YVSTi5RQ2Olq8CliTQeQbgJBEJvur1wb1FAWdFe93eql0Fqc6a12OCFxR7ZfvDeT8RP0lh/mLPvon5mqb39rkZhlq4uke4UUmKmDPPDSlG7TQiPC8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418609; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eii7O+82MnnxsBybXoQq8+VX2IfpzWsgxljJ9DRCO92hKy1AgFo99lCV6oRydXcIM1dfwxmB/VvhW9BVoSPBFsjfCPk+3LkWkWUDIcbqFMcH9LuZifgQRSS6vLfw5RR/OrWJe14ssChcKhc9oyEUJw9lq5DulMGZ7Z+riICt644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iH9mkNTY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJORIRuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH9mkNTY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJORIRuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784418606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=iH9mkNTYSPoGbD08Lhq3f/+b7nwIZ3Y/xxMJPbtBfRfyiqJlYM0n5aXCj+OryKQWFb22Tp
	Xsz3SSjOkciUluVQI366pvZ7XJZO7K7ie4oTJlbxRcLeilFl4sr1UWL+cyYARgzRh5Zkyf
	X1icpm7ZTMMzLotRCucEj7dkHrS1axE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-rEVd4vUUPOuMiE16S8TT4g-1; Sat, 18 Jul 2026 19:50:05 -0400
X-MC-Unique: rEVd4vUUPOuMiE16S8TT4g-1
X-Mimecast-MFC-AGG-ID: rEVd4vUUPOuMiE16S8TT4g_1784418604
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso6250291f8f.2
        for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784418604; x=1785023404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=TJORIRuMuVR/PM0iM+dcZxxBrlNGfDjBcwKV5iBI4PkjKFC+1lrdtKhfrkVS1vSfwU
         SID28urmvB6F8hZDVUqt92o9fmQVTINb3WUeoG7CxSS7ATz8F6dJhScHwlcriVrtXKlM
         fyQThVeABicyIaej+mFOzNGUa0r7j1AymCGx/CfSaa+hsZAa8kjsKo3GdCeFHJBh82LS
         iFq+jyOJONXXPzCywV2ldl+4lnzyreoFwXku30MOBBLBIvTpWKEdL1h8+7Q+r5hkwJxz
         8ib1Yz+F8Gt1xHRXQ+afoWafuuq3t9hMzm1Rwy0Ucm+nzxaDq3IajHrggn5GYrW07Ri+
         jOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418604; x=1785023404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=c24AyBs8+Rhh8nUfgEY5qM3R6KgzK6WALyZ/qaKTGZVuKxQPMg34rX7I52bA+MXyXn
         xcZZY/g1P9nDeehv5IEReb9Hw5mewwp/qHVIdOuIV1kc/Oi8vpf0gU0VpYRsvDaGaI3M
         SaxF15qVnFmZwap/QNegVp+4jMXP7df2SOcapYIzRgjnJj5akAAPAd2S7VmxxDEFz93J
         V46Id6M/1c4gD+z/Gs3MfMMcTLqhi+fwxE4cWx+Vn92uAlN4mDgygBYuLrkuuthA2zm+
         +mJn6fIXvrHX1VNAC/Jdwo32oxn3A7LAZI1nEIr52mxvPUXvsk6z7nqq4Hhm54OojB0A
         0oLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLjfyvQ4PMNn+svjy1II8gWQD9r6Y7wCi1AXzEPTUlQ8CABSdXlBBGwWWUzW93riYJmLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwM2+/V5dyiPpqO5WR1JQh8gXVuwX6BM2HlkM3YgK/ADrSVoP
	PtS1tdko/HjeyaKSIiTumUGmFfjzwJHbiWYhlmgb09dfmIsUpdrgKyfWRt2Yl5PrpLAj1Ht02CD
	uCi8MWP4f6ODMdZZ5WKJP4n7FgXAZ/PW3cmnAA50aeLJlIGlUZsBR0Q==
X-Gm-Gg: AfdE7cmUwjQfG+AVoFp3kA+pXeEQjTGfGI+yf3RvYAqEPgg3xTPUpqi/HCPFnm7n6uw
	dmFAaNvwj10pC/ndxvu/4H1nidaBZerfEg8R6kWhWtI5Q+zUSfRzHaGxvaNudbk8AX0vlSsqGW8
	q245wAt1S7FwmRCF8WtT5bqxW6lVCGqNA1OCiJZtVwby4DpYL8i4r2YeWHmJGr1kYY/thU/V/Eq
	b7c4q94g0tGgYK7h0/LmbWZ2NFFOFV204xUtFMAbBv4NSMhIBnTUWTrHRMZ6on5P7gXEuXdwkpx
	1TQythaQY+PxjvXWhbkR+ndvBcDmksDwK4HpxYzFnd33A66yr3EQeXBjDWJsygglYflk2ZzZRzL
	Oo8IM9+Y4KUXLWPlGtOjVuWyCJsvOPT/jPoAxRbP9S7Kz96qCwE+0YVj+nAruJ+B0gQs9WHp1wZ
	TLsVE=
X-Received: by 2002:a05:6000:3113:b0:477:47c6:36e5 with SMTP id ffacd0b85a97d-47f6230dc46mr10589676f8f.25.1784418604217;
        Sat, 18 Jul 2026 16:50:04 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:477:47c6:36e5 with SMTP id ffacd0b85a97d-47f6230dc46mr10589655f8f.25.1784418603681;
        Sat, 18 Jul 2026 16:50:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52f81sm16841322f8f.9.2026.07.18.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:50:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Phil Rosenthal via B4 Relay <devnull+phil.phil.gs@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Phil Rosenthal <phil@phil.gs>
Subject: Re: [PATCH v3] KVM: x86/mmu: Fix use-after-free on vendor module reload
Date: Sun, 19 Jul 2026 01:50:00 +0200
Message-ID: <20260718235000.50192-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-kvm-mmu-cache-uaf-v3-1-e103b93c74e1@phil.gs>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

