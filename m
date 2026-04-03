Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97234DCE0
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229295; cv=none; b=tG4kGE+JgnEnmNC3fx3yK6OqBe8Z1fsWf65bHLpGEWLHVizyLZW8MZRfZM2xd2fW/g76d/hzJGCbYbEhkT9DlawPNFhrmIuxyCaJYizoZwdcd6eFuGJYi98iJxgNgGk+jeb8SrppPDaea/pVD5Ih4rixO+KGBOPL2HWZkuXGofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229295; c=relaxed/simple;
	bh=oSBpzlNzrPKzL/ChMaUzCgjVvAH0N5JImdk4wLqGMkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9J5sMrl5aKuZ5lMwEBiRfc3KE1vO5yJbyMu1dmOdkq7znOtbsmQe2s8mOjbUP3xmm/Z0QKisX9k70Aoq83q8yxT3Ns5XNcgXN8fGcAaWNvYSywiIedD+s3FW0JHA3vg9uyoERygjr8+28VYr1VcFm7co4wVjVSG7hIqAwWXbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8piaPz+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8piaPz+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso28938905ad.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229292; x=1775834092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eC1+qE0EJKrpXXLd0Gso4B038Q9Dvv7sKHtMZlikTtg=;
        b=Y8piaPz+LycsqnIaPtImVqcoUXaO6dxAcftT1bD0vaJNCeujvoAY1DsnRjye2t2fSN
         BCsLBBDHQrBbLMv1kV2/i27R3ZgXFCyjabTONrRfvpxp3QsaEUVrVcLG4/wouBQXby5V
         jo/clE3v43c8LpaLZNe7Xi/QOxLisH80K8IDZcQ8nd/fY/uiajuZDPM7X+fWZB+cYZN0
         gzm7knapp57sgxg/j4C45M4Rj/irzGctXCuX4m2LYUjTOrlBq1OQbDTYIsWQqXsxFHY2
         6R874RrH9vrNWX55TSKNRfLtuG0T27UsSH5Afqlh3owoN1VbbsNaAKdsNge7s8A0bpGQ
         XDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229292; x=1775834092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC1+qE0EJKrpXXLd0Gso4B038Q9Dvv7sKHtMZlikTtg=;
        b=QmryFVcI7sASlgjq0Uz8iqogG+P7v3K6crIVlXW86fOGLM5t6MeMlWgNiDFP4pp2Nv
         B+xSDuzwZY/q22WWmDFIWq5g2r6zP6AlduggPfTYupe2Unj2OZkalvemhqabTiHb905E
         cF3crnxqm4P1Wv4OFi9L5mt3BdOe2/FB0olgsayAH+oXwbhL3soEimyqig7E+yKVxjWg
         uxSQ3siNUB+ksrrvOdI2mE5AOhlNnPb7jHcdkMkGE5GJI9sSCxvVffMk8Zvd89d23spc
         9pngD5uKjhwyVaKtj01i2usouseO76Yd+9CSWPFe+u/G7nzk7S3bJrhnWGYIe2+je8kZ
         dkAg==
X-Gm-Message-State: AOJu0YwakNL9bBFgJEPrhKIdXz/88DBOIR9uMuqqGaIOiqL+3rXHhCph
	Um7mWWs5n/TUsVufE/rVjPqROz+WC924fAswd1tTA4RspazmUdqzm+E3YgY9eWSsjrs+7ebZ0kr
	E7RwvBA==
X-Received: from plrd24.prod.google.com ([2002:a17:902:aa98:b0:2b2:470c:82e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:183:b0:2b0:5626:f75d
 with SMTP id d9443c01a7336-2b28176974bmr34719335ad.26.1775229291902; Fri, 03
 Apr 2026 08:14:51 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:56 -0700
In-Reply-To: <20260310220414.2569208-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522858966.291831.13668925839280843452.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Mar 2026 15:04:14 -0700, Sean Christopherson wrote:
> Add a helper to get a pointer to the corresponding VMCB field given an LBR
> MSR index, and use it to dedup the handling in svm_{g,s}et_msr().
> 
> No functional change intended.

Applied to kvm-x86 nested (on March 13th...).

[1/1] KVM: SVM: Add a helper to get LBR field pointer to dedup MSR accesses
      https://github.com/kvm-x86/linux/commit/0b4a043a5414

--
https://github.com/kvm-x86/linux/tree/next
