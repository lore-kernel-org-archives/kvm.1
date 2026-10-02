Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBF3C81B9
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975296; cv=none; b=TFS6bMWyRmAZXngVamin43dPzmQruky7bfVQyuOUm09qA6rLW2AEvBqBZvfNSXjAKCmlOy4REH7J23VdsW8Ln8xHzFOgfStTgE1Zk23bY1XkWe4gPU5ng7FokJgeLdafLPM638wo8SVLpxkA8ZEfUlYjEiOKYypbLNEEYD7d/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975296; c=relaxed/simple;
	bh=kq9QBghL40dkfA1F5V17cYmnpGDV/utwNPq4lbzDp1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzSSeriAfy518J1u1tuYSWp0uL38juQ5jrxf8XIolRqQTooYOw/wCAbvMhkSUiIZsFtcetdbZOkOw0cDGMFAxVKgCwJFoL7OvZz7IuTXa5tbMcdifutJEgaN2mp8KRuow9kJvRItCp3ybWjUnFswLUlyp/qWIFwjld5gQeJ6Wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMvMKvTz; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMvMKvTz"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so471450a91.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975295; x=1791580095; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIA33Q6ZV2okJc3I0sp5o6bypG+QRL/TeBpUQuge1fg=;
        b=IMvMKvTzRa4M6lzXYZ99QKWyMvlepxxtHjg3ZeGMSlmuhRSWqOpB8QzQ8Clun8co8r
         odjGJOvJgKsluF9ZPb7ynj1Pr8yoAFeuz1skGOK2HMivouw2B2qFsUttvm00la/ejAvJ
         cAOe8S5k/Vtt4BK8l9B8COsFkDg43tOWgKt27F129NS4Yy9XEuX6ICLkWo+N5bVgSHgU
         FGGbvvXz8AdciXKt/YnclZaXK7YwhipYYM1O9Dhaa60ETvLdTazB/LbTbgEwRE3OVNjc
         BNVTw692mrq8yVxBxHWiHmkPfaJHKmYOiH6vq32DBuAH1aFb2CWLfgYIPkXDtYnehQ2w
         MJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975295; x=1791580095;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIA33Q6ZV2okJc3I0sp5o6bypG+QRL/TeBpUQuge1fg=;
        b=nDAQvI4fPiMhUqPfDPLbiixhdhihuiOArvDAD8fXbrsFDOg19mOCPLYYoeTgjFu5Um
         s0X2Fefj6aLPTacx2/xyUulH9AwdshrGxJ7eDKxBXeiTQg7sVrpOUMybahho7uF/kK7l
         csmECIzy5CppRfpCe7edGJIqmxEYNu1AFfbeeVfKH98/cluwiP8MjS3Fk7h48NVtOhUx
         NsCA1jslb8AarTDuRAVps6D4ccKXQJCFlTF2lLIqE0Ly5Wkx4RgTM3rjjCd7dHIr/mxM
         znn6QCCj5Uf4KpkcWuiPP2CuSpQSN7leEMi22+3o2x8eQp/ZnLVJFKVdqmp0ASSFjTgb
         KZRw==
X-Forwarded-Encrypted: i=1; AKwUvBzu8KYFAay62Fb+xSsAMSJUEcdvj6u3McD/5wEKPYR/z4QXVfEDrP5LIz5lEXUjXkkYzko=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHHab2myOwBhhVPKefQau6KVVa4dfI+SluSob1TOuQIczdkbcg
	QW9iYC4Xkh2TaKASf9Qnz0dShZugolH1olDoLUDzzgMs/f0tVDolwWspNYwkBXTNtgQ1gIGiKNn
	qMPSI3w==
X-Received: from pjbmd9.prod.google.com ([2002:a17:90b:23c9:b0:3a6:df94:8170])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548d:b0:3a0:f0a4:a2c7
 with SMTP id 98e67ed59e1d1-3a6cec13a8emr3789780a91.20.1790975294587; Fri, 02
 Oct 2026 14:08:14 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:52 -0700
In-Reply-To: <20260918054420.338842-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918054420.338842-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097475934.4071676.12331909604242085588.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: selftests: Move test_read() into elf.c and delete lib/io.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Gokul K <gokul02k@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 18 Sep 2026 11:14:20 +0530, Gokul K wrote:
> lib/io.c has outlived its purpose.  test_read() has exactly one caller,
> lib/elf.c; test_write() has none at all; and test_seq_read() is a
> declaration in test_util.h with no definition anywhere in the tree.
> 
> Both surviving helpers open with
> 
> 	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: selftests: Move test_read() into elf.c and delete lib/io.c
      https://github.com/kvm-x86/linux/commit/3069f4036dff

--
https://github.com/kvm-x86/linux/tree/next
