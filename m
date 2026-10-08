Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77A471D04
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482488; cv=none; b=DRa/G2eJPdPEdRsAJAfTF0LMyFHmYAG1h9d9npABVR4IBbltgLIkP1mvm8y4YsEGkBSTXgaaHWS/LYRfCpY2VxQMYyM0JK8pmG0wxn9YSePTPN4rE7TlkypcJskciS7BTXYtZ80si1gtmJNWDKHHh+JaW9kJIJFT//g+c7UB+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482488; c=relaxed/simple;
	bh=RQdoIJ9m2tXOqTGElDl6SMxGUd155p60PG3ZO4gRAis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkI2Xtu2YQrx2eGhmYsYfpD5HEhwJUhcXa6kkARCHgl8QEqTbROcLbrb+to/HRG1EA8U3y5iP19Wc+U9cA/g0BtUsI2VjFJnNuxD+bPGd/dCChE8yKFdrDX/LwPdLVW/hYY4pEfDHIiKY3wk9e3OhnONDj+BxYDL05coEfeVK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnJL24+O; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnJL24+O"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88c768886a6so4624879b3a.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791482486; x=1792087286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNqpYNwF7OxX1db3IVJpKf2Pi/s0gizYzeK0ndBB4gI=;
        b=DnJL24+OI8C6OSNi9vgDleboyMQWgfTRbGN4ydMGb4Q634NrP5ZmiSD1oPGkqutDYN
         mGjFN1wGbZktNAed2rCmFCyLGCza3ojyIZAT5upIf9x54SfI7V9Lc9H+BXQfcks0vB2t
         uVqvGwuA3lsoQsEyT2nsBkO6mSVON9Llv7bjIchK545b5yp/FeGNCSXXJHnrGUcjoFqI
         8sZCB0Xc8cfNO4ok3NbqGz6rBQZlZnP9vfMqxmoIQucqWWIrJd8Qk/QhJcWSO+ZTuMfZ
         XvPNze02sIUv+K1YBl1pcl8kt4hZ5hwqhSycPhql9URV264MsgsBgPMhkst8rebF08bo
         jO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482486; x=1792087286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNqpYNwF7OxX1db3IVJpKf2Pi/s0gizYzeK0ndBB4gI=;
        b=x7+5Eh3UMunnRFugW0KzLkd9txGWbYy2BZwjQDh2TFTw2Y/EGPE/RpZWi56f2hp57b
         1Qpa8EWpISh0cJtfQc3YBJ4+YlpNijUyKdT1Vw0Uqe55zCRzkRomUanhYcM44KvqRloT
         LBmEqpXRJuKNIoc9rHopZhjhIrD4hZGXuxakw8XNY0TFSrrshV2yDCYpJfVrpdBVsHFT
         iuaX7vo5ltQkQk1HENFaHWoWtldZdoa6wyVPxP5yY6gsIHpWwRb3DQ6JcchY6BqOaLjE
         nS9RjdpVhY44aU+NJKbqGNdZGgus8MSULme6WyprYYTN3IEUn6+bJeKIo8YYWneSkZuG
         PpZA==
X-Forwarded-Encrypted: i=1; AKwUvByw7d+g2U13Dkj2lxZS7/c0IyhPBei500eTlpoRZv8L6EmQw/92IOm3Klrq8ir+sb/HfSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtZPO/YnpxDI5vSBiYmdHkr+Ru9F1mlc6wXXWRb3HZUCxPgv23
	eA1nWd+ijclA4VsBV1Lh345NdMQLbg9xoddlJuLtrdCtjhnf6IZskhBlu/HS0rCVzoZKKdtOoFS
	zeIzH5ZXABKBEbA==
X-Received: from pfbhc11.prod.google.com ([2002:a05:6a00:650b:b0:893:7c12:8ae1])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3485:b0:87c:e6aa:30ec with SMTP id d2e1a72fcca58-891b4fd6deemr5227390b3a.49.1791482485388;
 Thu, 08 Oct 2026 11:01:25 -0700 (PDT)
Date: Thu,  8 Oct 2026 11:01:21 -0700
In-Reply-To: <20260310060022.15120-6-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008180122.734219-1-jmattson@google.com>
Subject: Re: [PATCH v3 5/9] KVM: SVM: Extend VMCB area for virtualized IBS registers
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:17AM +0000, Manali Shukla wrote:
> From: Santosh Shukla <santosh.shukla@amd.com>
>
> Define the new VMCB fields that will be used to save and restore the
> state of the following fetch and op IBS related MSRs.
>
>   * MSRC001_1030 [IBS Fetch Control]
>   * MSRC001_1031 [IBS Fetch Linear Address]
>   * MSRC001_1033 [IBS Execution Control]
>   * MSRC001_1034 [IBS Op Logical Address]
>   * MSRC001_1035 [IBS Op Data]
>   * MSRC001_1036 [IBS Op Data 2]
>   * MSRC001_1037 [IBS Op Data 3]
>   * MSRC001_1038 [IBS DC Linear Address]
>   * MSRC001_103B [IBS Branch Target Address]
>   * MSRC001_103C [IBS Fetch Control Extended]
>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
