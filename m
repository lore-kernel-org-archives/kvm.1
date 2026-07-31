Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F638DC6A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528717; cv=none; b=gOip086KqwJ7IA6R37cMVMtv/+Spt8zebkpAlorXNobZJyEa66IX8X0h+3sFZ6kxTVoN113vvF/K0+PsBtBxqNK4FI4lKvHH9VvnCTCpnWiY0zfPzFDB237NbxeVo+r7gqF1EXueW4mqyfPDLwrpCLWX/ZbnHWWWFDbI84/f288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528717; c=relaxed/simple;
	bh=LKYqx7EorJihnFYoF0kuobzpzTlpOBflC417rkO6xl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdEjsdqSgV4fqYRc7cdlNe2s7M1B2xiCm5WEuzkOQqjEXwk7hBxN7w1JaG6u45IGEe54Ol4ltUPigx53W3pJMCOZswbSUx97rzH4QwszHLfsZix9C4o+jPM5ccp4iJsxtobTKeyA4kHieygdsVtUHNv/skJNHuzrkZpaDUEpGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTciskHc; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTciskHc"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1453422a91.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528716; x=1786133516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sq/FckFrpyv30OYyCfBkf9U38EkZq31rb5BRk6efzf8=;
        b=TTciskHcC2aNXGxluT5l/WR7US3pAi6cRkIg2/MjSM/5n/g2dDy9cMW7rGwAWe7C8O
         GlMiJjMysT8VxEMTVbChutHlXjreIstbYLCarlQ7CqjOULcjaSMJJnic95EPGqYDz3pz
         1DLesGVVixVoYUXdiqv3Kw1Vm8XQkf/nqMEATi0zxsQ4aJ79z1e9wrrDgGlyumXQTSEa
         0RdOsUhyJKBjr+DtjD4cOLcRKFiDZLhO90VUZQW4V7UHoebDob1/1RQu4u6Li7B/oBWo
         GnQCYwnmd/pwvVz57mtlQwwNVfHQ6CY6Z7S+JrWFlH3Qs0UpDFeYiSSM3fp1o4tIpnQb
         KtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528716; x=1786133516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sq/FckFrpyv30OYyCfBkf9U38EkZq31rb5BRk6efzf8=;
        b=E2+28lP8yXMUHZaJIA5vGb53PzzKEzB0NCjHtkK03ja5TTrDibvbAq9xA9F3EAvy/j
         vMUupTO2hUezRoRgxaYu8V5IGrHv0G5WW5V0/63wZcCgN6770bD8XNLUKuvFw303CSkJ
         rL3xgAsIX4EE+4fmYTa3078uJee/qAtakf1a2uOWzw+AUtM3MdmUTsAO5sqysnSNRjzm
         WqSx+Hn7MfTb1SbxKYffD4JxzURqSmZMlCb/4iIACtN8anP5tv6cvJfg4XNiFYWFZVDW
         n88evT60u9Fm5LuDJxq8tBoFKBoS6fRm9S+Ua/UWM2rLvRvYRFRR+r0b3jHGB0mzIcDH
         Ozuw==
X-Gm-Message-State: AOJu0YyUmIrbY0NWINJmOEDYHIxgjLfh+3n0n8XZ1yxoVoSf7L6tO0fp
	HuyB3maPFcV9ZXaUiOGVOsBDJ+/i34OZakhdj+wkdtJ4388PhiUQU/XsNGXZiw1yIyDMiNN46ww
	XqFEKBw==
X-Received: from pjbiy5.prod.google.com ([2002:a17:90b:16c5:b0:383:a728:1317])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2692:b0:38d:eaec:4396
 with SMTP id 98e67ed59e1d1-38fbc437d5dmr952084a91.11.1785528715721; Fri, 31
 Jul 2026 13:11:55 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:15 -0700
In-Reply-To: <20260723211306.75397-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723211306.75397-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552830245.2708509.12741282098867699823.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
 SNP-enabled hosts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 23 Jul 2026 14:13:06 -0700, Sean Christopherson wrote:
> When {de,en}crypting memory of an SEV or SEV-ES guest on an SNP-enabled
> host via a temporary buffer, allocate a full 4KiB page for the buffer to
> ensure the page containing the buffer is wholly owned by KVM, i.e. won't
> be concurrently allocated and accessed by other kernel code while KVM is
> using the buffer to {de,en}crypt memory.  On SNP-enabled platforms, when
> sending SEV/SEV-ES commands that trigger firmware writes to memory, the
> to-be-written page(s) must be (temporarily) assigned to Firmware (as
> required by the SNP architecture, to guard against using such commands as
> gadgets to attack SNP guests).  See snp_map_cmd_buf_desc() and friends.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on SNP-enabled hosts
      https://github.com/kvm-x86/linux/commit/a33c40b93ccf

--
https://github.com/kvm-x86/linux/tree/next
