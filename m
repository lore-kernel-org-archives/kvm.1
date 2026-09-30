Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913D3264C2
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791251; cv=none; b=j2pIUYC11bPi/Mk5m/Avycciy8BbGBEcnzqX5glxX1tF8rqA2kwAPDVEm0YOJl3w39AUo+ynoNAQAQpeYYTDHj5a0J+8DvGW9lhvjjaSRB1SGL2j+fkXPEDe4gxQmGlpyEL01JAlPUw4/1JqFngQSNizbrAN1hCN9mzx+3/3uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791251; c=relaxed/simple;
	bh=kKJwxmQYGEh4yRpyp3saGtgW5y+BMbbEt6Y9VT7jroM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t32OZ9/7P+aEGGuIXba/kaOWqBlzyihDwrVHfXwOE1xwT7JSLZvU2gmXoMnMgmFkJiUA752weEXnY/KXNcPp8ZeLqS5GxTCMyeG1XE98NH9hAS+SNTfS9s+BeFQVpnkJwAxPTu/Z5ADRA9Tvk+YDJXBDvPp8o6Qqb5FgQIp5ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMjeuAjP; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMjeuAjP"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so4068114a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790791250; x=1791396050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi4wlBHO1Ds0bd9dYrKHwvi8qQBb7k8RirKZz6DIk1E=;
        b=lMjeuAjPDWJ8hDQdYiVbjrsdaL1KZT2siKuuujvvhV9bKE6Uyx00kyjKGmiTnynAJM
         l7zF8i1nCPM7B+gVPXc8oAhdR+3sdPD8E8kysCCBcicC0uaHbNOkoNzvuar0sWYpdrp/
         q44CkPm8eX3GDBG0trXJ27lhUcz00jKsTJUkZyEvx5aZKjBuPXyCzo9rn5inwfuyXBPo
         Y5xf8N6VlFAM2kM+4WIq3jVXHIW+t3f7vqTzJsHpfZF5rZLRUfkeTO8JCdOkkUAXMS/4
         qyk3qAaBIwT2d2NbIThtCHB0DiQPtfd5UylOV6sUI3vzSeFbrRFmVPQg/kyro+zfS1A1
         JJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791250; x=1791396050;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi4wlBHO1Ds0bd9dYrKHwvi8qQBb7k8RirKZz6DIk1E=;
        b=IrlSHB+DYz//EbmXWRcZZNWsz7GP+J/oyvZ9m9bRJC8kaY6sInJfzZZW+Kd1mq4yNE
         8C7y7l5OTkFTh24ufDhACeglsd5ccXOx/soiPXElpSDxydRlKpKo6MGTGeES3QEw7agJ
         zBUV32rPPSYPWjpgzyIvk5lY1jhC0DVpgqgEHVtKg7cTWaOc7g4QQXj6cXyQ7qmnA4+l
         THckDPGeXzu3Yoejpdwhb5TquJyNzSKMR+yEV7sS5CQopUJTqZi6x2AhdQPDjfVKFrzX
         1BODDFR+juYlDi4nn/NMwjtWmybnUx711J4fgP2HNDdll46oJvtlzxWfyjMcSe+kMCj8
         QctA==
X-Gm-Message-State: AFuF++nYeywBrdRFIHrP2UWti1ph+BSKLrzXopQwcdHPX+kOVuNK9W64
	85XroTMIgxksCI3smlOhVglfeKt/5xJYumKjnR7/Iwto/QwB4mhTum1/cHZ7ETdHOg2y0phXOSb
	uVOtoVQ==
X-Received: from pgbcp9.prod.google.com ([2002:a05:6a02:4009:b0:cc7:ad09:94ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a124:b0:3de:138f:a9b3
 with SMTP id adf61e73a8af0-3de9e6e4ddemr2262862637.24.1790791249278; Wed, 30
 Sep 2026 11:00:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:00:48 -0700
In-Reply-To: <20260930174504.7738F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com> <20260930173635.3362655-9-seanjc@google.com>
 <20260930174504.7738F1F00898@smtp.kernel.org>
Message-ID: <ar1OUAyYks_n1NJM@google.com>
Subject: Re: [PATCH v3 08/21] KVM: selftests: Rename TSC freq checkers in
 nested TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > index 84312146e93f6..e5fc4c9bb9f9b 100644
> > --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> > +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> 
> [ ... ]
> 
> > @@ -45,7 +45,7 @@ static void compare_tsc_freq(u64 actual, u64 expected)
> >  		    actual, thresh_low, thresh_high);
> >  }
> >  
> > -static void check_tsc_freq(int level)
> > +static void guest_check_tsc_freq(int level)
> 
> [Severity: Low]
> The commit message states the goal is to make it more obvious that the host
> version *checks* the result and asserts on errors. However, renaming the
> guest helper to guest_check_tsc_freq implies it also performs validation,
> whereas it merely measures the frequency and invokes GUEST_CHECK() to pass
> the value back to the host for verification.
> 
> Would a name like guest_measure_tsc_freq be more semantically accurate
> given the commit's stated intent?

No, because hopefully humans will understand that even though the check is
ultimately performed by the host, guest_check_tsc_freq() really does check the
guest's observed frequency.
