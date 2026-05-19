Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F425221DAD
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151507; cv=none; b=MzQtcCmw0JpBRSV0Miah1v2jxPiIY8TpqF5Ni8QI9hBAvfQt0P1f1lhu3XJIWpyT+FQuy/Wm5sXupYc3JBTUvPZgS8yaaT8L42MvOpMOKgIidIRrzHOvCpQPldKAlCQUnu6wvfELnuREYkN6AqoqqecGgGRam1uJlGKK0XKo4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151507; c=relaxed/simple;
	bh=DJa6+wvn4O2+sL1BsqY1Pc9sjHLtoYI7jtnoQWs1KEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m7+X3qnL4TWricL7gGqVPiVOxXmsSkM9bd9hTH5z0g/4m96mrJfwjwJ1Ww5o9a/DzBv7iMbu3rxAzzG49wIeoUouMfmudIXMKEoWDS+zwtOjExITEAWzUM87j0VIDOMCFpLjOxoj4+VinBjSAK46iejCnqS7X1slBfsY9wsr6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+etTgfG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+etTgfG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso1837270b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151505; x=1779756305; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggd5csVykghtggMe8pbnnA/QKuDIv0Rv4A5DdUcY2V0=;
        b=I+etTgfGMKFGMAjhXIylAbyVBqIzUgewWfFEcpMeOIvQv325EUWUhgJfczr0UDO9/w
         s6qJjM43p+0Al8OIWmEFVa11sxWKMUnbZTtG8A2hhx7h963fYkn3D26fz9xO6sgt+NM2
         4R7dzOum3c9Z/J++CvDhpzSJld08PHzIXB5/l2LtA3rk5FvG9XBf/DFYE8YPvbPK10z1
         kmo5MdOkr8WjVJQSwNsMhI+TVzm5gdvg7Y7hZbXXWCbClyUwV9NIS4DGodf/MlUzfgFJ
         n7C1nL1llQ4uK3neNIOEkplbV/xejzniTI9IQSH+aedl7vYhOK/HiSwVVymcLRnT7j43
         1L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151505; x=1779756305;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggd5csVykghtggMe8pbnnA/QKuDIv0Rv4A5DdUcY2V0=;
        b=TN0beDhfRwc6avPtGQ7ngR9hMZEb24Ro9/TDxV2OX7MKsyM58/a6P9yogWZY85Nbeb
         FLe1zSsaQ/84BNKTWDooMdp9i4m+4otwnfye7Rg6Lw7B/g493CRKtvGMwYJNW+NuCq/v
         NHMO6VJluXEzLaDGem+iXFStHgM9e75uFBWn5fuDHBmme5VntUSnl3v4d8aly+AOUhMa
         FAC7iImIWotD7l80ooYecDLrt+kZVriH2UWi5JO/UjzxREY+9lJ4FER9wAQeABHTz6Sf
         tnL0Qs+UrqJjbUOuMZUOlt/W2rG4JgSLqqsFDpBZyqeMTtRM7bK2N8G8X2xSXcAgav4H
         2S8w==
X-Forwarded-Encrypted: i=1; AFNElJ9tod9kOx2r3xfICHsGrCxIkS8qxQIWJyO9S2YSxq+YBN+aEjwEPLWp5qYFdDMNVhOfJzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1Pg+D5Sl/kz3CF3Eia0SP8BDi8/t9CoLiKq0a5aEaoLPi2zG
	UxrPm7FNtRvnV22uT0mAELu/Nsak20ge8HV5RNwMLCbXG7DDBpg/MU2zjHKY1Rc7iBcyB4NO+3A
	jGxrNOg==
X-Received: from pfmm23.prod.google.com ([2002:a05:6a00:2497:b0:82f:6a88:310b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca4:b0:82a:5ef0:210b
 with SMTP id d2e1a72fcca58-83f33c255c5mr15421546b3a.15.1779151504718; Mon, 18
 May 2026 17:45:04 -0700 (PDT)
Date: Mon, 18 May 2026 17:41:11 -0700
In-Reply-To: <20260410232654.3864196-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410232654.3864196-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915046516.2224783.65133220965322974.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kas@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	binbin.wu@linux.intel.com, dmaluka@chromium.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Apr 2026 16:26:54 -0700, Rick Edgecombe wrote:
> Rework tdx_has_emulated_msr() to explicitly enumerate the x2APIC MSRs
> that KVM can emulate, instead of trying to enumerate the MSRs that KVM
> cannot emulate. Drop the inner switch and list the emulatable x2APIC
> registers directly in the outer switch's "return true" block.
> 
> The old code had multiple bugs in the x2APIC range handling.
> X2APIC_MSR(APIC_ISR + APIC_ISR_NR) was incorrect because APIC_ISR_NR is
> 0x8, not 0x80, so the X2APIC_MSR() shift lost the lower bits, collapsing
> each range to a single MSR. IA32_X2APIC_SELF_IPI was also missing from
> the non-emulatable list.
> 
> [...]

Applied to kvm-x86 vmx, with a massaged comment as suggested by Binbin.  Thanks!

[1/1] KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()
      https://github.com/kvm-x86/linux/commit/1f3e69af5f93

--
https://github.com/kvm-x86/linux/tree/next
