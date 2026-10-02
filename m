Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAC443C08
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975493; cv=none; b=qkfETolNvG0QwzNb13Sj78a7HUgAi+Nl56ruksgkfcdkOmLSbQL9/2zmaZTCtl+QZQHJjHrMlurCYBpqoSVCWnLALiBeTXldqT5VeWwhBNnXHNutIYSrmCvFCblmpD+mhFqXHYy5rGRQaQiPlLLUl0W79BCkKDxv5J1CEtrsk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975493; c=relaxed/simple;
	bh=7HP8j0vRbaMczyRcR6MqI5PEt57F9XkP6W2Sf05zWDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rptY334p7YZ6WPpY8Mgbxz7mK1jY8g8oZC1rOYeKnaEh011Ow8ShUIT+yV5o/tRNxhqNbkQ0qrqzoQ1UFtCJqfgemh1HvQJCDi5987uTDgKiDksPqG5UkrFxOt+lnZ6GdOtXt9SQHt5CQGyXElp2xosdjwZdNQ+dUV7SJpuFLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvXriXXj; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvXriXXj"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so15420a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975488; x=1791580288; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQy8amvB/kaTOh4AUTfTq9TAn2udFtua6zNz9l0R3d8=;
        b=GvXriXXjQGgxhW6nuJVImHLTQaJjEJ8ngujesgPjZMc2/5N/tcTV0ESFnNuq6y7FIP
         S1gFBfyjxUwLBuFuendH9FPI8Q9RcdwwX+G2vJNmZty8bi4y0JFv9YBt/YoTsEDhp6L+
         2xqaP5dizLVJS3uCg4LSbLyf5XPCsfMM1tPqR27OZIBQrGQj0qXjnpIv0whlMrhdsh05
         jzGZmLK8Plkh5lZnCf96pRU0hfrrQUL95/wKFQR2qxrHrmw3mRM84EJLc05AMNEUoL0u
         lyZGPWEIJScORL2LULsTRqd9p7KiKhexya9ucfjB/2Hpt/S0zXl6PM1BFZHHpSszQ2Dv
         1guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975488; x=1791580288;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQy8amvB/kaTOh4AUTfTq9TAn2udFtua6zNz9l0R3d8=;
        b=aFY3zVcOX+ia8ZMPfKvdo5CfeIqo9R5FnVmjWKTtc29WQC/nYJgR9WEyX3vB2l8Ev3
         gGvNvizVY65Og4qkmlami+NkfHoB6vfLFDR4G9ZAcG3wS71JSKAjvWHmkSK55stXlDG5
         bxGxjTfeaWsV0IcUkMyBnWApTlXvlSHub+8HlkymwuiHtS5o7Csvb6thyk7sIPfi3+rQ
         R5CFUkLGdZTPpc+UQIRzaehIzx60r5EnUYiBNDN3Juo+dYYjT2GFoB4fx7cx/aYuezmZ
         ko1+PqrLL/IvGSUG3Q9cgpsEn8/kp4r3rOmbOuo9pI1NYNyRJ0xfN94+lM31tqntj/xL
         V/Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzP1obPLkuK5Hsak2Ka+BqILgIiH+FK/DZ5Fxq+GsztzsF/q7O4U6oSJzo1rTBZjmMkTQg=@vger.kernel.org
X-Gm-Message-State: AFuF++kvOUXkbz9xLHIgNJvqQGUDbmA6BVhZVvAPQ8ZDa1jvN/KEG1pR
	+Otbndgm86WLPdwKMc1QP7UgP8rzudG8+qCuCGMQsvZH+xZX94XiOOVOrT+YFoD5olEcinjirtP
	5+7JqaA==
X-Received: from pfbhu50.prod.google.com ([2002:a05:6a00:69b2:b0:88b:55f8:60eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:ed0d:b0:3de:5a00:e248
 with SMTP id adf61e73a8af0-3e0bd479eccmr4003281637.76.1790975487779; Fri, 02
 Oct 2026 14:11:27 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:32 -0700
In-Reply-To: <20260923-snp-invalid-input-v2-1-c00e0dd077ca@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923-snp-invalid-input-v2-1-c00e0dd077ca@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097473116.4069804.1607082912708388223.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Jacky Li <jackyli@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Jacob Xu <jacobhxu@google.com>, Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 23 Sep 2026 20:18:12 +0000, Jacky Li wrote:
> Currently, snp_handle_(ext_)guest_req() returns -EIO when
> kvm_{read/clear}_guest() fails while accessing guest-provided buffers.
> Returning -EIO causes KVM_RUN to exit to userspace, likely killing the VM.
> 
> Fix this by returning GHCB_HV_RESP_MALFORMED_INPUT with sub-error code
> GHCB_ERR_INVALID_INPUT to the guest and resuming the vCPU.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer access failure
      https://github.com/kvm-x86/linux/commit/003892d6e802

--
https://github.com/kvm-x86/linux/tree/next
