Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF23AEF2D
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022721; cv=none; b=koRtVQl8YjWsWM9ZWNga9sBRXWj95cWitXeOJWzpK9DrsNqU1c2xkB00YoSRrXxxXrwSD3lqjpq/+sPvorH4+RLyhDgHYOr1lcaCyWqlgHFsMjkxX23RKuVteXxJ7gSeYkAMNaCpBpw5wbUXS358aRWvs5avDhr9GSgU8YsFar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022721; c=relaxed/simple;
	bh=uFMk1jZpsqtQJeUv2lUeILt3cXF07gHRUuncT5eLn3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIt3i5TeBU4AwOigxj/mpDbWrmDZKYvLPuy6rFtBv855XAdF+GnDY0k05aDqQAegzX9tDnuZ6qvTB59nCawUNPN4Dd7dWvp8KEbLyaxsIELlk6yg8JAmtWUB0vPJG3U8FwRUqaTj+ZKtBHGShkMhElL+UK1oyGMC0Lgi65i2Y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5xAJzkf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5xAJzkf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c1e112dfso79764555ad.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022719; x=1781627519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iK2GP3Rc5BEFQ81jZvOlP6jemB19dD+1/HetcsN7sU=;
        b=k5xAJzkfARY5ZNOj73G4aCzuaj0FCK8kgabwDI3HQoQU/YodxJU4SkAAMiLeCZPM6u
         z7Bwu9tG/QSAIYL/JBzU2dfIBjiten8hlF05Pc9zyUX91/6IlZqsXJEuGMHlAEIPuUJm
         aZBxtYG6JT1VJUbwodE1K04dDnoca5GFMQuArz4f43pkYR8iE1rEmgtmGYAkXzaiBoeW
         SQW/UvVT0eQGoWHxEUSszC2/WBuMIfWa6yFUBhfR/NwQtdoQb12gG2XWqJLAlviTCMzr
         MAzOPkiH4Iz5wJ9jzu4j5aa2Gqw4qtWDup0JL3Qy+4YsAoJNsdY1VOhddRqqJd9XpntA
         hP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022719; x=1781627519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iK2GP3Rc5BEFQ81jZvOlP6jemB19dD+1/HetcsN7sU=;
        b=ALY2LXZw9n4ev0hBq7b8fU9liEj+lA8QaOcUFZpafPI1O4IoeuflI68c3arz5ZCAgA
         hwEXaS4zmByT92+ABgcAMxtVz7ttnbYlxZnRfm0ACQHlWkDzEsr7lGAsTWwMg3GjcuCK
         TVBGoJ6cLsr79tr23AtnVLu05U7Y4R7akQaZ+5G2t1TxNjdJp39vOMjY38S1OBdpD5gy
         mY3wA4gIrUHaYwugZEYZPjjH+NlS2+O7zhcokCjqSb3kBt3uM3JRcITtCV9AMy7qMoCW
         m67mm6z5C0e8k03dBrARfmCWWRQwSPhxXDnDr/c3c63jjxIPwzPiOXNeAa6LnkzclUtA
         LIgw==
X-Gm-Message-State: AOJu0YxWFfpYdFYz8F50jVyPdXZyY/zrvFqAR/W66AZp3YGA9/Fp+R06
	8AY0oUiuDHnQNwQmPNIAQZWXGMLdo3B8LxQ4IhYhQD5XApmrBDDmpmDXZIS2j2SCXmuymnyOq5h
	mB9J5DA==
X-Received: from plcq4.prod.google.com ([2002:a17:902:e304:b0:2bf:2cd5:1d4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc8:b0:2c0:d097:51ba
 with SMTP id d9443c01a7336-2c1e810bd08mr256584395ad.26.1781022718467; Tue, 09
 Jun 2026 09:31:58 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:32 -0700
In-Reply-To: <aiQyZIJtO-2Aj_xN@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aiQyZIJtO-2Aj_xN@v4bel>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102220971.2734517.14635903505526070729.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: hyper-v: Bound the bank index in hv_is_vp_in_sparse_set()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, vkuznets@redhat.com, pbonzini@redhat.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, Hyunwoo Kim <imv4bel@gmail.com>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 06 Jun 2026 23:44:52 +0900, Hyunwoo Kim wrote:
> hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
> HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
> valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
> set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
> must be less than HV_MAX_SPARSE_VCPU_BANKS.
> 
> The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
> which is below KVM_MAX_VCPUS and therefore always within that bound.
> The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
> hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
> without any bounds check, so valid_bit_nr can reach
> HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
> valid_bank_mask.
> 
> [...]

Applied to kvm-x86 misc, with a heavily massaged changelog and a KASAN
splat.  I also added a 

  BUILD_BUG_ON(BITS_PER_TYPE(valid_bank_mask) != HV_MAX_SPARSE_VCPU_BANKS);

to ensure we don't re-introduce the bug if HV_MAX_SPARSE_VCPU_BANKS ever
grows beyond 64.

Thanks!

[1/1] KVM: x86: hyper-v: Bound the bank index in hv_is_vp_in_sparse_set()
      https://github.com/kvm-x86/linux/commit/4721f8160f17

--
https://github.com/kvm-x86/linux/tree/next
