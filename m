Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2F3EF669
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549458; cv=pass; b=NeOmNmPlvdRLADVJshhGbO01hjXdAKui5Tr25rTIjNJ4/VSENgJw/1/KwTqDrrrSHJDCKRTK5yy9WRnOLC5eDcb/b4ZEzKJPFi5zJwDYjSK8LPH0uYuXBpzec7FIfhOms/nGhMby8uDjY1lj0yMs4My6SCVWtZnuQ88mRAXn8MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549458; c=relaxed/simple;
	bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiQrZNhIMwTVZ5PYrVAmkxA7SPosqlBFjYhccXinukbcjCvK/e2PHUoEWoLfflGc+KphNHM613rG/5JQSViZO9jOpZ25GO3pRWQ6YOeM2rbiOBOeGjqFBmtB1j/Zuz4U4HufOY7YKVvbffCTi2kInF7sFVHBjj5IXCfGKipZIQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctP+FRKu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FifowGsw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctP+FRKu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FifowGsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
	b=ctP+FRKuOLwaplD21MC4GJ2JOiXlXAyhZ6II3hftsLKcoyttqABWJ1KfVerrwOm0t8+ymo
	MhgwxwEWodbrmYoee/JFE/4Lc93MIoovY1OUoCRT7L/gMqLUs0DQEU9pXXbi8raS8foy/W
	YeuKliBQCO/X5i5s+kke7yCclXhS2V0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-dLz3Kve6PM2i938lKoMRAA-1; Thu, 26 Mar 2026 14:24:12 -0400
X-MC-Unique: dLz3Kve6PM2i938lKoMRAA-1
X-Mimecast-MFC-AGG-ID: dLz3Kve6PM2i938lKoMRAA_1774549451
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso687841f8f.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549451; cv=none;
        d=google.com; s=arc-20240605;
        b=jAJsN/JCOrPbjevoMRuKqXbYvMaBIstMn1eR7QlSbZKbj+A9LXhhY946YpeBbx5PMg
         pCf+Y5XkDVigcvfGq1Q+MAmYyHDRZe9oLqtlAsLVDoZAVUVyskdkSGJDNQ3XiRMbILwO
         77Vv5ZZNYf+10KIcqamMork+T9V/d2K+PtccXSZVXNGUmMMG0IXELjZDSeL9OXWrTXc5
         G0PMKfC6g0wb/pGB47qCGpaOYEc2yYVqconcc1vX4phudIBQ3WYX8rwj2+EJw5ey9VNZ
         u9jTqKwKZvC8HWWdFCfP2mFhw52sfTbM9+FUCb2tUI6SrHLliPR0PQkDygqFrbVzZd1z
         DZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
        fh=44ihW6hREQ4K5S0P9k5dwclAauqQfpaIkhr4vdzaEy4=;
        b=e8z3gfc9yXYn7NOrNC0p/ToAhef6LRsfTxQly8fyf1rZfCbQSP0W6fXnloBYw2QwWj
         Tf0mLFjrBt6jUeVHuuCT9wMJIWxI+y8NpQa97lIDfBq819/tQooDhhFEmv6oP8tjDTC2
         T39J+fnEYNOM/FVEgh7TjRUXTuuVPIkc483CGHpdpEXFn7XhOF5JhbJzXvkX8GhadcOA
         lSwxZyLenUtbifdf6ZaRNv5VB+qWwQUL0MSQ2o3Y8IW6cBC0vveafU+DJ8gUR/XE5Lbg
         2PiRo4ESH3DEv6ez5tno0BZjki1kxFJxVsYWQEYQxNRr4WgtxuFDDRpKnSHDd+s4V7BM
         XMPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549451; x=1775154251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
        b=FifowGswcCEjILMgYN3v/HLj1uTkmRbou0nX/xLOpPS62/1ApilS5ckAUB4JPAS7Yf
         1v9Zy+mqS/RxqN3dKaxYEhrX+R/rGW2LAWioyDojxq8lfumq1whgj8pLkt4MuQfaJZCH
         wJlCoU+sPG1BHZPEtXKlGHeiKYudne8vtA2URQlXm5Opx4+OSJXKJs3OtnJ300Uzm9JQ
         PoJlGXaozbMjZLNYQze7C5Cf5wyb8j8y2kqoTYATTdW6bpjt2qqKIm5b2MSf+5/aqrXJ
         N6NVsvOMK7CdVYnrhh/HU0NO4C7I46sh4oSfaA2kyxFGM5cQV1cjO1OxsJ8MnAjr+/Pw
         4lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549451; x=1775154251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQMGWO3Jb9ZRlKPSLzy+ZfSrt4QpEsmLSFST3EKzYAk=;
        b=SZdqFNuhJ8bwTFYVeJ0CPdismfq015M6Y5QKraeNSgZNRZfx6iWvyuAbD7KoOCRA+Y
         FZgSwypYGIV8bKURoAWiOLsXgfHNeRQ5kbKGOO1dR56SboECHp56mVl6tNlgwOfxwZKc
         6hbJRvS0GDpPc/E7akgoQk2RNxGORzZlwufXht+gXME9gwXAOm5U7ypDv2IHYybt9gtc
         D3CzMiTOIF25jqD6SXZ0XB1tHfjhPTwxTjRpxo7PFvyfchp3x+BjQi4GKh9KIlnGyoyp
         MU11p+DCWaxUlD077DF6VlASpY43txfEgT8PeVDuCRsSGZXfV1Si2ba6XXPM6TvWjcvW
         /7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXmUMu2IlT3TdTtKdhgaGfRDyLolZvQ+qmJHKHT0UJZVaWUTQDwsf1N1WQU92lKm4sMknA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoAv3uDbbVUOEtInwKFAbBHlcBcBI4rjY9n+yxIjmLHG9T5vCr
	IJATWdaA/RfattNMT6I9R7YdYobBVt5s0bDYPws8h6Xu8G/LfZZ1DT2wq8KOt9LPN7kQ0vYkFlS
	G/CbeTZbttcumnqyXpTICn377j78wJepCwdtACIqzsTp6bygC70AqOFw+WzepT+Ji943eKcPBsz
	JVgp+/vcWcf0WP9RRGAq1Y/DdbP43c
X-Gm-Gg: ATEYQzxr6cx+h6sWXoTdoYDyUC5203akQiVoc1bQeEROcjorPjyNKQJq1ec5v8lvy2h
	I+m90SQiVQSdH6aCA5wPPNHb8Qun6Ep7jNhnMRsrzsnrYoYeiE4iH8wYaaXfR1D5RhOnsvQTK8H
	t3ptoiTRae0yZrRby3Kg/b/bheWOS4I4EnHdIGNwgRg5BxrL6HvsuCvpgYxxSRbr7L722Vu0z3i
	tRV68FHeI+ktqwoGq9tVVlAt1m2FyWbj8v7jDDIvDMBTaMP+ixLmCZmoMay4yh4Wv6rQ2icnVht
	RNQR
X-Received: by 2002:a05:6000:4285:b0:43b:45a0:9df8 with SMTP id ffacd0b85a97d-43b88a0fc0bmr14534067f8f.35.1774549451019;
        Thu, 26 Mar 2026 11:24:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4285:b0:43b:45a0:9df8 with SMTP id
 ffacd0b85a97d-43b88a0fc0bmr14534017f8f.35.1774549450552; Thu, 26 Mar 2026
 11:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41> <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
 <abMS7MALNrmluvh5@acer-nitro-anv15-41> <b51de5cb-8198-4664-afcc-7386ecda81a8@redhat.com>
 <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
In-Reply-To: <acNwYsm4GfViqiJS@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Mar 2026 19:23:58 +0100
X-Gm-Features: AQROBzAmyn1P9pR-79R4cWceEXwBMD15hAO83tLul9jg4y2-Qgpzo_wGmuGmSBM
Message-ID: <CABgObfb8POHRUmhu2yoH7B=m5eg_VQpmDcPoj=PttaRkN=dQTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 25 mar 2026, 06:19 shaikh kamaluddin
<shaikhkamal2012@gmail.com> ha scritto:
>
> 1. Added oom_enter callback to struct mmu_notifier_ops in include/linux/m=
mu_notifier.h
> 2. Implemented __mmu_notifier_oom_enter() in mm/mmu_notifier.c to invoke =
registered callbacks
> 3. Called mmu_notifier_oom_enter(mm) from __oom_kill_process in mm/oom_ki=
ll.c before any invalidations
> 4. As per your suggestion, move existing kvm_destroy_vm() logic that alre=
ady handles unbalanced invalidation to the new helper function kvm_mmu_noti=
fier_detach() and invoke it from the kvm_destroy_vm()

This is not fully clear to me... It could be caused by a recursive
locking, or also a false positive. It's hard to say without seeing the
full backtrace, but seeing "lock(srcu)" is suspicious.

I wouldn't have expected deferral to be necessary; and it seems to me
that, if you defer removal to some time after the OOM reaper starts,
you'd have the same problem as before with sleeping spinlocks.

Can you post the original patch without deferral?

Paolo

>
> Key Design Decision:
> ------------------------------
> Implementation point no 4, while testing, Issue I was encountering is a r=
ecursive locking problem with the srcu lock, which is being acquired twice =
in the same context. This happens during the __mmu_notifier_oom_enter() and=
 __synchronize_srcu() calls, leading to a potential deadlock.
> Please find below log snippet while launching the Guest VM

