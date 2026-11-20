Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183768;
	b=0e9sDA+Xbg3HozSFJ8SWE4VAM5xsLTItOBe2SrN5fHpfzypIOWrnlHXJwmj1CaMp7zA4
	 tihSLT12/GC/hgAIT9Fki4Ywx2cFZHi7E+sQZWzBugvofJiUGfxGT8j+OtQpWXRiv6EXi
	 jzS48QBw0zDEtr0z1uZZKOw0Bf6ctxTMp2VmUdpHLSXb0+D3M1j/g5fDtWCe3SOi33Vzl
	 O80nQ1aJiTAlC4PBNUDxflIKMeFTYSn/xZVjZ3jjIanQHTqBKNygXP5+67IE293tRy6F6
	 FmunCigN8oom6HG3+yJmpjAkLcmqGmkTB4oiuujGxnQvJX1VqEG3gIfJctmww7dgCjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Fcs0DJBKtZLUxloKKuDwNaVEQG5Sv/NarhrhzSQukPk=;
	b=BV58pVS05ofY5z7RNB0ZgfPmVr6JOubeWvaHh1tQmMeChGj5fIrQSsQ0vxhEoQ6/+siJ
	 6EjCMT10gUabykRd3OS5mb75IyUQNFNCwbXRmwngt+Gi0AnrDhgJrlek8s6AgMtyr0SYO
	 67PR8eoLYvNlPJ6BDl44BI89WQO42H6SSHVyaB6NBRpqDVzXaeOueUF0pMaHF7QF1OAKY
	 V4TpwiSdlyQNEGNDmwAxFcgGKoi9QGBci3vpMOz+8jggodcTuQc5zABSJErgdzncuVWPv
	 Pmk5l+f5tnm/dON5ejdKkJ+CY1dtJIhdrovyT3gNBSKftej6PyfzTdbrMtJybdG3OMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=phsZOd6F;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90309606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90309606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=phsZOd6F
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb86c39250so617749a12.2
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795183768; x=1795788568; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fcs0DJBKtZLUxloKKuDwNaVEQG5Sv/NarhrhzSQukPk=;
        b=phsZOd6FHm2fLXlBEPUk4HxHQsr2YjaF/8w8uBbsM/PVnx356OU/hMbwUbzUHLeBg3
         qHulj4rKFN9eSri/EBSKVaLa+0AQcb3ImuX8vxCNSMnrR8V4jU54wTq6dFhHpi71fH/z
         6XWFpi8deUl4U2lVzNSiE/+4/UY2tuES1tkJhoC5wME/1koEmYrUy2UyQ4zF3rnIdiAG
         TJu2vG9djnhknQ0fmwqmmjfxBxl7SrmDA2hz0Sc6d/KfCkF1tkKrSF4jZZUo0Paf6fJN
         zBUoCLo9FqJpdsnseJS2iTmbWZtGMaTAuCyL5OEHvpppSWxcOl9ntNLlkK99SXPO9/6y
         kEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183768; x=1795788568;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fcs0DJBKtZLUxloKKuDwNaVEQG5Sv/NarhrhzSQukPk=;
        b=TD0EDka20KEPIIJlKxjSl7VPqsBMku0AsNjAj4rFiSOL8Jg4LP6ze4nqsBwjkAtNAy
         1DZwNoxMxrBrL0DeE6EeuizI5CzkSedrS5TwQJBm2sbEP4LyMHVIP2xag3BjiNJqDLwi
         /p9SgPk4IlLWeNJvm7Gt4Cb0STMeE173PJ73Gcd6DGYGeuKJ++ENv9HjU1oel6/VxtaZ
         h50Ta892ytiMi5E4sBazAYqOPlpuZQsOlEBOosjhuNAEuGEpMePeo1QjyrjWE2DeRTAn
         t3FycuFMolaxlIKraDdK55i92OzwnojmNYiPzZTgYLMHneg3dZNrgUVOxh2ESj0XfP6z
         UM9Q==
X-Forwarded-Encrypted: i=1; AL+hErEHTaQKt8kU8kLkIBB/Bzoee08sh398hlrcOOlKh+AFAEEeLCu2K94Id91OK1uF7hp47zA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NLT8bVjsAim+aTUVjrErDccC07s0NRKl8sSWG7MD7k/VyLX0k
	LJVq6jLt370tvGb8wJv1ZnTyHMZmVQ29LU/wOKymd3YntfD9Xv0QKKMhYb1umCHGM50c/amrPYL
	gsGo3Lg==
X-Received: from pgin4-n1.prod.google.com ([2002:a05:6a02:8784:10b0:cc7:cad8:adb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52f:b0:3de:b95:d50f
 with SMTP id adf61e73a8af0-4014c945bf6mr2794811637.24.1795183767718; Fri, 20
 Nov 2026 06:09:27 -0800 (PST)
Date: Fri, 20 Nov 2026 06:09:26 -0800
In-Reply-To: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
Message-ID: <awBUlv3ItZiyZvlS@seanjc-mac.roam.internal>
Subject: Re: [PATCH RESEND v3 0/4] KVM: guest_memfd: fix NUMA selftests
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>, 
	Ricardo Koller <ricarkol@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 20, 2026, Shivank Garg wrote:
> NUMA selftests in guest_memfd_test assumes that node 0 and 1 exist and
> have memory. However, nodes can be sparse or memoryless which would
> break this selftest.  Select the nodes from MPOL_F_MEMS_ALLOWED instead.
> 
> Based on kvm-x86/next.
> 
> Tested on bare metal and in QEMU. Without this series, the test fails
> with EINVAL when node 0 or node 1 is not an allowed memory node. With it,
> the test passes for any set of allowed NUMA nodes.
> 
> RESEND:
> - Rebase on kvm-x86/next. No code changes.

If there are no code changes, then there's no need to rebase.  Please use
RESEND if and only if you are sending the *exact* same patches/emails, e.g.
because you missed a To: or Cc:, or a mail got dropped by your server, etc.

If you want to ping a patch/series, just ping.  v3 is sitting in my TODO folder
and applies cleanly, i.e. there was no need to send the entire series again.
