Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EA361DD0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975319; cv=none; b=bKCiUpnowyHwfuI42TBKxIOMx19I7ZCqK/X9wZE8S00mpkCPbcXhy+6L3aT9uVmFOR/s035/k97N/5TAop/tez3FOWFqeLnFBsffJdp8N89tIwz0uT04Jwi6xXduWmf4ZsNUOc+s8Al498t557dSNzkv2U5TGbhKEEviwvfoXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975319; c=relaxed/simple;
	bh=qQHaUt9Qx5ui/jf3XA5Vx5WKrzuF2vNTVY9zHZ1+IO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5q7c117Gq/C+o/J7wrOrt/5e33+1yCN4g7fni/fXIrA/KyfJw372LTVYLQcWlWeu57jbbcBrokLv5G0XXzWR/PMKaYPbHF6hwUzR+R23+MSY8nF78vYYmD3q3+XSPBM5KKGxMOsjCO1nIijsZF/L8EyMqe1fjHBZfcRSAh9yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTHVnQIr; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTHVnQIr"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39533bb224cso295732a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975317; x=1791580117; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXEfwIOrmzhpBjI7xrdNHIpyWDkfRzHF/aF4EjJTCJM=;
        b=rTHVnQIryc/r/dGpsTYHEwVq8muAbWn83N7iVF+z/vMLf88XupNiz6O7clrfXZplvD
         OR3jpBAxh+4s9brWx1B4KPmHRF37y3gqp9ijdT8/bWemR/Fd5p8OL/usa+w8Qdk0+VHs
         X9MHq30HhYLSgQhepI31fFx7zcNEUr8wQowW3fM8wCw8AvgFoMYWPxabBs7bf7lvseHP
         XvlepOVkqDSLK4mzZnwU9X1+/2RrFbWSYDbcaM38xB53vSow0HAp6ye9AHqRT35EEb8v
         2FVRgjEeWUs26s6aSizMy3dFFRF9BW733ohk1v+rBdBEWNLvDm1/5NMjdlcbwY8Hmboa
         dZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975317; x=1791580117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXEfwIOrmzhpBjI7xrdNHIpyWDkfRzHF/aF4EjJTCJM=;
        b=aBvGtca1ORrV7Lf+1DlFnPlByMBbu6x8BKWdDasMjD4LHb8I6vQ8xpbh9/HBy40Kv2
         dj7FUXWlZENP2WQP2dflPZbF0tG9ERe4p7hH0OKTaCUDfuHkOos5kY12wtjvNPXx4BFM
         n/RQrpXKZeFkJGllp9s2ICWCe7TDM3pcf1WqUXlvnehrnZ9TauN2GGBRr2UmphzPBWEB
         ytsugPSv7yKWYe06x6WBxbURCzO8yGP+hsvNvSLL9cd8CjsGDHMjm99dBsSeekqZi2J0
         2QMLMWTD2euLnP+CwkLCV77uXmqvq1WDTOLLuz+FUgDeiAtYmVExgeVDvhG/TanUhjFf
         6v3g==
X-Forwarded-Encrypted: i=1; AKwUvBz08aq+fQXf3NG2q0iklrAVIdkI8KwBwt0+JncHYy/kJmiQEPoHaS0/fdwnaHJn/QJG33A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvxL7v1HU5lzRLV5IrlAByoz6VYvC8CAA1C3Nj4mtAfkIthZA0
	a+nFvuqeTEtb4jFbHZziZygf2489tapngUzgVDtQp4oAXmHn5j5l7VbnXReTFhWYSLtUeG1uRCW
	UHCbAxg==
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:3a6:c8c9:1392])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b46:b0:3a7:250:333e
 with SMTP id 98e67ed59e1d1-3a7025038dfmr1422619a91.11.1790975316920; Fri, 02
 Oct 2026 14:08:36 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:00 -0700
In-Reply-To: <20261002053723.3275202-1-loc@ryzome.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002053723.3275202-1-loc@ryzome.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097455441.4065912.17506123016485694511.b4-ty@b4>
Subject: Re: [PATCH 0/2] KVM: x86: Fix lost nested APF VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Loc Nguyen <loc@ryzome.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com, 
	x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Oct 2026 05:41:43 +0000, Loc Nguyen wrote:
> A nested asynchronous page fault delivered to L1 as a synthetic #PF
> VM-Exit can be lost after KVM queues the exception.  Most callers of
> kvm_queue_exception_vmexit() arrive through kvm_multiple_exception(),
> which requests event processing, but the nested APF path calls the
> helper directly.
> 
> Without KVM_REQ_EVENT, vcpu_enter_guest() can skip
> kvm_check_and_inject_events() and re-enter L2.  A later VM-Exit can then
> clear the pending exception while reconstructing vectoring state.  The
> APF reason remains PAGE_NOT_PRESENT, allowing a later regular #PF to
> consume the stale reason.
> 
> [...]

Applied the fix to kvm-x86 misc.  I'm going to hold off on the selftest for
the moment, I'd like to go straight to having it support both AMD and Intel.

Thanks!

[1/2] KVM: x86: Request event processing for exception VM-Exits
      https://github.com/kvm-x86/linux/commit/88b23a2e8286
[2/2] KVM: selftests: Add a test for lost nested APF VM-Exits
      [SKIP, for now]

--
https://github.com/kvm-x86/linux/tree/next
