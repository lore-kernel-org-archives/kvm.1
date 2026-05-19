Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602624DCF9
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151353; cv=none; b=TjFKXcqkzjylYVDE4o4eV+RPUafQcjzzjBc/Z7Pcj8VXzCJf/JPCRw4mETd4PDkWblBNAVDDoezetcf4cVUMujpqaeyDsKrgh96TLCLnhZjdyWys/fZnI0O2ABHuReiENo3BHS/3TZRdLL7IrqDbSo3oMl9nWUrHIC8lpzAnm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151353; c=relaxed/simple;
	bh=IpYOpFfX4/OD8IEZLfAVYLYMPVpaeg1xGH+f6nBZSWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPGHefNQ7YLoTCXTRB7R5X1qAv4YfjIhbxwBeOn0ZrvMHyxKuzFw5AszzrH1Nk3XbwImYEaVfZYI1DPctddnMIXbwHiY8X5lN4i9uJptuc9Ar5f4G6LtQTApuuzATjDMrjmbRe0NnCKqg5joxN0UBaoicrkNqTO2ExAaNtFZ14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DE3fqxC1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DE3fqxC1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso1836097b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151351; x=1779756151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=icNlWn+8QPxDo5dEHHdYwfmcjbT1Orh3zLu0h9uaeKQ=;
        b=DE3fqxC1TDL1PtdvhH9sM5z4Yp+qZeOi6mehtuiZHRKA40MG5b9yhjknjzk2eIfw9Q
         PAwBSsEkZgJ8JcRKWr3DL8WrcPlSwfJuJDjsD3zs9PKiIHX8F9oYUNmugQWZCWXUnw6d
         UnyF/e0c1ANIXg9snqCEXq45R2CkQUMX/lVzaEBks1BJMVugOVozcmWWguJ5VPY3E2X3
         TkeVlbrEmX+3flTqFxdo04PT03IgAXrBQ5XqHM1qvIYd+LgWd1KrcB0e5IBbAt44/3Af
         nFH8OKz1lvEQCc3SNdNDrZVOWUEQsMXdRrbKmD51wZYNZNSubYrZy3zIQq8tnU2OzAwh
         DHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151351; x=1779756151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icNlWn+8QPxDo5dEHHdYwfmcjbT1Orh3zLu0h9uaeKQ=;
        b=JUTo8mCojdDVwvTNkJ+KnDEKg9d2Ks/5VNcLGbsXOQ6mNSvGDBE5jm8CGZ5AZCLeHK
         BBQnNsCwRS3hDI8j5kY+RbZFUqQZzLqJ59VwUpGfPpV4CibVUB/wX58jyVTJj7a8TfkY
         4mvlWR55fd4ltCEJQpbipTGSRnGxCKEp/+9mTfpjZ0daBPMlwukOIlFhxY1iUBpcbL1A
         aMYAqShPPlcFhlh5woyQbCZBYPVlYpF+ytfxodQ0WOKAjROcPQvMrQnD2b2V4NUzzIgz
         zE8RiYUIwl3+TgWOceE1F8FIyW6ziurEIEyyLIC5BJogENJylNAq2az2FhhjogOf4abI
         MURQ==
X-Gm-Message-State: AOJu0Yzg63s7ofKMUCKgKE/xq4mrAFMINUbGqr/iP3FiysXs0xqaBhQq
	YbcaYGZHHwpM7sMafKL7hs7qFQ0OVcvrOAPnx6EW4uREbJ5C/wJip5mtAU+3nh6lEkMum0v3cM9
	/6935JA==
X-Received: from pfblu7.prod.google.com ([2002:a05:6a00:7487:b0:836:6e32:7280])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a9:b0:835:4291:6975
 with SMTP id d2e1a72fcca58-83f33d82ffcmr17934598b3a.39.1779151351029; Mon, 18
 May 2026 17:42:31 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:42 -0700
In-Reply-To: <20260406225359.1245490-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406225359.1245490-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915071468.2226831.14635720413149875996.b4-ty@google.com>
Subject: Re: [PATCH v3 0/3] KVM: x86: Async #PF MSR fix and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 06 Apr 2026 15:53:55 -0700, Sean Christopherson wrote:
> Fix a user-triggerable WARN found syzkaller, then clean up related code
> to eliminate potential stale data usage by removing what are effectively
> duplicate fields.
> 
> Ethan Yang (1):
>   KVM: x86: Don't leave APF half-enabled on bad APF data GPA
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: x86: Don't leave APF half-enabled on bad APF data GPA
      https://github.com/kvm-x86/linux/commit/923ca078f08c
[2/3] KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
      https://github.com/kvm-x86/linux/commit/3c0bf11dd41f
[3/3] KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS
      https://github.com/kvm-x86/linux/commit/7e985021ef2f

--
https://github.com/kvm-x86/linux/tree/next
