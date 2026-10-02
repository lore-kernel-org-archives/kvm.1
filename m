Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F430569F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975324; cv=none; b=tdz4yMmY4R9rms0ZPg7+8S9IEWFFqIT4vmacRyoPK2JPA8T0jOS6oGiyZnXvnA1+1gK0Cp4xyNHXYZ6da2Plw4/U8L2ndIISznL80c4/uFE235B1byWZXeEZ72/J/fVcMdhYV4XXQF/qecX+pw/qUM3jObqlhfS25HOnmeE6YNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975324; c=relaxed/simple;
	bh=BNCCxFi18w1ak7m4lkei6nr0KoedI/99IGKv5Qxo+QY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxGuRE1YDCr/wl7W3/R6Mp4l7wZrjRX2Vyrl6aWoHR4b07MdYJ5pjJjXwXTwgBrWfIUsOcqt9+lEaajb5jr+wwGsADdldGzlDFvtdHVjs1yK8YLtjRZRFnyfrB+vDvfI9AF8UKSKd56fUOmZtX+PglgwOwUFOmi82k3+WikFoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfJmsJOy; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfJmsJOy"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a0f55a3941so7812645a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975322; x=1791580122; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mn1hEl1Lo8aNhx3q1qMVfBokbtTDpcBlb0AsG/zX97E=;
        b=TfJmsJOyBigUarR9JmygnsI9RFAwlGgZ7gMJlrz193howtYtqyxVKxdKmgszNNN0yk
         yFeRnMgZbQt21ga9//psqNCO72MRnEDlrXjrjCKYHr3Uznheh5aQji3I+mfQHbfETiF8
         SfohBMxV7iS+L5HHsoxylxYXGUzLr9fwnTECT+ZwDRGRDa8GZXkvBOgN+CupdEQdl63S
         f7zLIYhzuNwaW6WNRXvxQX5kA1iDH6cluM6JEDDcHRIcJ8X0TZ/Xy2aeXxozCfoAjep1
         QQLYENGQI5OfX6pmCtRPjq0eyJBul8iQ3XwXgSP113iWazPbs9Htxjf/PYjnLwxa5Zcd
         Mrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975322; x=1791580122;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mn1hEl1Lo8aNhx3q1qMVfBokbtTDpcBlb0AsG/zX97E=;
        b=x96epRUffv01im2hJSWUV74ReAM0dAqCGpF/1HstCBudOrQmW3ucVGWq4aJwNkdKH6
         1d2iZcWa/NOq597L4Kbs6TzFV5E6BlHFTF5XeIDtzXiitjdkuW8pz2j/ZIqJkZKuOnIj
         axya+XpkPc06kpl1grF6hRd+afDE0wT95ttOZ4S6J6bDhefgkhi/esU9aPAv1QRLHJ5M
         lZy83WSqc+qLyJ7c/Fy48y5Mylm8VM7VZhY8JgmhubJm2nsRjLA9qWkn1go3Q6/lHCG0
         Kju3wPiYZyTo88S/nIrhq4+qhvfQYnM65fGsHVl0hErnsFnmVWmJDHeCgiB7xyPR3Rx7
         uHTg==
X-Forwarded-Encrypted: i=1; AKwUvBwLCmv8zL88DqY5KhRrAKqduh8may9u61kaeudt2Ddgqa1zhb+3J6mVOp/sFOGC/+o0cWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0MDxkquYjgDHGpiNdshz+9hr3qp/LkEiGVHtU6obBiwyMe5t5
	Ft2+FT0VzBZDZ6ntEd3iDX1TwkirCTXsKC8ktB5y2xAdj4cji/FaASI6oWqd8mShwSMI4HmiV52
	wVEthdg==
X-Received: from pjbmy18.prod.google.com ([2002:a17:90b:4c92:b0:3a6:c347:6e60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ce:b0:39e:1310:cb36
 with SMTP id 98e67ed59e1d1-3a7871801famr264183a91.20.1790975321927; Fri, 02
 Oct 2026 14:08:41 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:02 -0700
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907063906.1964557-1-nikunj@amd.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097502898.4082124.6984085314381773615.b4-ty@b4>
Subject: Re: [PATCH v8 0/8] KVM: SVM: Add Page Modification Logging (PML) support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	Nikunj A Dadhania <nikunj@amd.com>
Cc: thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com, yosry@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 07 Sep 2026 06:38:58 +0000, Nikunj A Dadhania wrote:
> This series implements Page Modification Logging (PML) for guests on select
> AMD Zen6 and later processors, bringing hardware-assisted dirty logging
> support. PML is designed to track guest modified memory pages. PML enables the
> hypervisor to identify which pages in a guest's memory have been modified
> since the last checkpoint or during live migration. More details can be
> found in the latest AMD APM Volume 2 (System Programming), section
> "15.25.15 Page Modification Logging".
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/8] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
      https://github.com/kvm-x86/linux/commit/1065274e5cbb
[2/8] KVM: x86: Move PML page to common vcpu arch structure
      https://github.com/kvm-x86/linux/commit/d75bb23606ff
[3/8] KVM: x86: Carve out PML flush routine
      https://github.com/kvm-x86/linux/commit/e1e1934fea48
[4/8] KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
      https://github.com/kvm-x86/linux/commit/8ac111b6dc4a
[5/8] KVM: x86: Carve out common dirty logging update
      https://github.com/kvm-x86/linux/commit/8301c447b240
[6/8] x86/cpufeatures: Add Page modification logging
      https://github.com/kvm-x86/linux/commit/732cf7ec3224
[7/8] KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
      https://github.com/kvm-x86/linux/commit/5ebaa85a746e
[8/8] KVM: SVM: Add Page modification logging support
      https://github.com/kvm-x86/linux/commit/0d7fbc059f33

--
https://github.com/kvm-x86/linux/tree/next
