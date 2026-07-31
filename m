Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003436F8E7
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528650; cv=none; b=KIOlyXIBPqFEqAhY/51yMvUsJE3Ja0pfFS0EXiYYRGivkbWDHP6Vg1K1/7wQBabO+llVfw+6cI7EsIFUvXtQ81SL5xzgfe6DLvyFUEi09eYQFJ+mZCBjbU1j+e75SjBZuUpRSMB7aNeG7fN+TUD4wXCc7fMMMnrf4iBgVEscL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528650; c=relaxed/simple;
	bh=WKGilUA6z1xS2+KYe+1Pbmf9+AKYZLsJTDxCM9KzhWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rq6uVGlx94wa0IvisBpB8gy5ZzlSSmeC4AE3PBD3xQWhNRNBYXnzsT5ebXnR9+nLZO3jpSs8HCe2OASzHMDMUQj81x3acOlJBRIxGNHEDS0BVY+3WkiBBmGYqv5A+Lx/8tBNgN4mNyKLrpf4u/R6Cm5irvEqwBhZZWf0ictCPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVLP9aVj; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVLP9aVj"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2187469a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528648; x=1786133448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PG5dLX4kp3jPicgzyoTL8Gk0zmSpDLti1j1GJZwmrD0=;
        b=lVLP9aVjOByp1EzniYO6cw3EUcTHHcZKgJkpHQawaBNeDgUjjFzR3T61KvwkAEjltx
         tRgazTHan7XSE5978KBT7GVP4S/BAZUYK/M5NV2vmREq+IRsmCbuC+vKTy9wuunSDEnk
         bFvMXoumqatZaspAFx1pOiWuIIdW1dLH1ZNmpmUGTcIFi06jWXoJObrqzUHPC+GE3GJ/
         MU4uiKOEBPZtPWTqizLRdpQy+6zNjW0KZMug/f1WmcaYEtMkn2JARIHaBhMkF38c2oc7
         xbAob/BU8l6LJyJGCq/9JlJ8kH3Gc/mVsuG2zsjYsgawTjQOS9T2FeBO8XAX+DUIyDrb
         1j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528648; x=1786133448;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PG5dLX4kp3jPicgzyoTL8Gk0zmSpDLti1j1GJZwmrD0=;
        b=UYEagGaHCujGzv6knRLbF0XGOaNh8+OIhHuf421CXGod8T3OpgLRePZVos2d5EtMHu
         B7fx3v/ZqmI/ByyMOuNPvnRajcF0A4fw+h/1PwpLP5eEtN8uEc9WPH/ftJL+EeT5TDiB
         ffqmHt6yflz0oAjhk6hZ5WWQWYIMJbipC+XfdQYKd6srBZQh8spXDadGI0SaGN7+S7qw
         +yuufJRiBnlHmOFOHxjNNrkWKBgVoxN+/1F8jT4f1qlehDohCAu5YCrTnm3pr4Y7Qjjs
         71fpUfIiQxxEdJnSKRVTS1MGbYTuPukpLfTusYEeITUOonOduaxNlmEYV/iUoiitrkEs
         zH8A==
X-Gm-Message-State: AOJu0YwjnJeDj+M/fSVYE+5g+cqc2tw7vAET4UAsUyiiVXICvlMjosN3
	1EUaMQPxorgmYfPET3yU8k81inh+SDTxtuejJS5sk6hDvmcD4U8n81vY8WyrbfVGtBDuF5qZX4c
	E9FThSw==
X-Received: from pjbjx23.prod.google.com ([2002:a17:90b:46d7:b0:38e:8fe4:4ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c0a:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-38fbc3e5931mr971542a91.8.1785528648030; Fri, 31
 Jul 2026 13:10:48 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:54 -0700
In-Reply-To: <20260724173425.278753-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724173425.278753-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552817292.2704738.16908321315446827507.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: x86: Suppress false positives on "lost" IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+dd769db18693736eee89@syzkaller.appspotmail.com, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 24 Jul 2026 10:34:23 -0700, Sean Christopherson wrote:
> Don't WARN on "lost" IRQs if the VM has an in-kernel PIC or Xen emulation is
> enabled, as vPIC and Xen emulation have guest-controllable and/or VM-wide IRQs
> that can legitimately be consumed/deasserted without holding the vCPU's mutex.
> 
> v3:
>  - Add a helper to weed out the problematic cases.
>  - WARN in the "else" path so that there's only a single conditional branch
>    in the happy path.
>  - Exempt Xen. [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Don't WARN if IRQ disappears because it was cleared from the PIC
      https://github.com/kvm-x86/linux/commit/681fb81a4171
[2/2] KVM: x86: Don't WARN if IRQ disappears when Xen emulation is enabled.
      https://github.com/kvm-x86/linux/commit/4f05a3337d7b

--
https://github.com/kvm-x86/linux/tree/next
