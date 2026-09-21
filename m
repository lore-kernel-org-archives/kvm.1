Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E54A68AB
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999646; cv=none; b=gyyUEkKTMGSFQXW2Ezbj+vcjMpmuc+Mq6EXCc4C8ASRzXSoRHkz03TCzFiyTHwFxV79TbYjb97mh/D3Qr++YRaLUiaQcWY8aWCxNDsQ9OaP4PD64q6L/mARMYAF5CkWtwvs8pTUn+jjUT4c3/bFiDQpyW59Gkq9E4PPr0ETe3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999646; c=relaxed/simple;
	bh=aVY+77+Rg4LdrLfAH6xlK0pN+kCKSnGa0twjylLa7m4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=noyNiQkQ/FTN0+JpCuOTWBQ1hxfKORUdk7EqxBNuxU6CjqqmN3sonqQIlZ9EjIkrRgOk3Xt9dfsJBkcnRAlDzY87M734IhkcSooVJGL4059pH0cOcALulSjZq57T7xFo2qiqW35R5qmNIlRaXqIikRFDyZSojDJ+oCkLcA3TPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d36U9OqE; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d36U9OqE"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a880e91f0so5386799b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999644; x=1790604444; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7kVfEuUUuG5RNBx6vZsXAqf4DhBGNyoOU9tZbLc/gs=;
        b=d36U9OqEy5t1YSBG3G0wsA04D9U97Fvp344kSMe9WPaXa1qeOiup1nBk7QMtYIe4my
         59Duy4/P+j6qra4KJQypPXj4jtrzjJndcbwzKxZ5f5HNDOJ+TCuNgwJvIuIVIlijEEHx
         uviGmzzRcXLKLrFEMe4WBSXUqrUDwzq1qNjDHFsEF9ycwor9ix5OLAaqZW/Yca9Spqkf
         COzdtAMyYKn5XGwJkOBe2mOPOzLs77snnJWUD4fZs6ltlvL8Esmfj3D5WU0jOLaLlukh
         L7kP0lYBS7N7rXvfXAzazoyPk2yfRyQ3ceN+ET5zG8s1GQPp0KO1MgoSJVjBKi/O630R
         BVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999644; x=1790604444;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7kVfEuUUuG5RNBx6vZsXAqf4DhBGNyoOU9tZbLc/gs=;
        b=bRZKY8UspG5HwNiSJVFKAUXSAMJM7O1dUgoL0HfOm5qzzGynrwlv0T8shYYG7h55CV
         LEdPl7poNmNKNDzNoauKlYrS5epm7HQdrgXunjxSdLeOvksmzEf34XuEus3J4L35kios
         6xzANCmMakyURY2cDvYuNFxvHcX2LnqPin6A99xpfPUOS+3jGZtxjqZ9Ab/ZRxNP4ebc
         HNkRzcLWRTTN6c6m2D2426fB/A/Q21luWTZLEoqZdfrJHOtprhgT7lFqeGkRXdRFGELF
         bCfDu7Mm9WedXjYPHKF+WWOUe6QURfY/a0iYVaKROinuCy0ffbD1K9KcLYHW0gL4TO2a
         Cu0g==
X-Forwarded-Encrypted: i=1; AKwUvByl3mYSPmdALUHrX5Xo3EMNoYitfKRVELZptkz0aG79MFryKYWMOLgmGANkCTcUXKlAWQk=@vger.kernel.org
X-Gm-Message-State: AFuF++m+jsATkRTdXvz9bOPfafIF0lgGflySJeBBeIMGhq9ucc7+ICaH
	b803D+bobs6CYg8AFXHHgJ4hP+GkyWIauqDX4HOpjJGtR9g8yp8lVSHOS6WTxnqTs/EOqnguQ8Y
	qY2rvGw==
X-Received: from pfst21.prod.google.com ([2002:aa7:8f95:0:b0:87b:300f:fd01])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8883:0:b0:84e:d5e6:a085
 with SMTP id d2e1a72fcca58-874d84a92bemr15148212b3a.0.1789999643931; Mon, 21
 Sep 2026 07:07:23 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:32 -0700
In-Reply-To: <20260811050029.530698-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811050029.530698-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999927029.754512.6741483404933166279.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Fix two VMs leaked on early returns
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Gokul K <gokul02k@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 11 Aug 2026 10:30:27 +0530, Gokul K wrote:
> Two x86 selftests create a VM and then take an early return that skips the
> kvm_vm_free() at the end of the function.  Both now jump to that existing
> cleanup instead.
> 
> Patch 1 is the plain-SEV path of sev_smoke_test(), which returns straight
> out of the UCALL_DONE case instead of leaving the loop.  The SEV-ES path
> next to it breaks out and frees correctly.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Free the VM when the SEV smoke test's guest completes
      https://github.com/kvm-x86/linux/commit/434c50e703c5
[2/2] KVM: selftests: Free the VM when NX hugepage disabling is denied
      https://github.com/kvm-x86/linux/commit/ebb702707896

--
https://github.com/kvm-x86/linux/tree/next
