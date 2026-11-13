Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577935;
	b=GEIQZVCCiLWtfH5wYcoPGnIf74yPQJX1qFtTBxJRu3ldESxq4EBd3RMbtUonZe7eRuSx
	 MFfqolghsmwZ98dJ9250WiQCsHpPGXiC8Nnz5rHisEeQi4iyZHAdLdtipxJ4+32CXjy6e
	 jUYk/i+0x6Cd8vQVyWj86SDO3DtSgdCobByWQd6s64/7I1EunhFHEk8KCYyMXJeXKbpnL
	 VrcvBlnBm387vqcsvphEsW7BwwkMbqpV2nM64ysszYeUQHfMlDGubZAnXm5wvpVyzXTNL
	 C1x7q0z1CuRNoLqCLpao6RJdrojCM2UboXUKSLSnsIR99IMqF4brfMbl3Uba1yjBgtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
	b=nZjhPA/89IGuCP8rof0AeMIt/h96J4JcHG4BlVMpzYRYOt4Alsj3ZPnxtPEXHZWQ0DPe
	 mLIDP6zZwV1AFLKdO4lTERrocHQtNK3fbpb05eBR1kY+4DOSjJTWeVSFej/7pLK9NX0XV
	 pJhWpxvuH6/CT+I1vU/vrAwYZC13hO3twW3h9UoxgJTakhv59WxU8r/QKaTPPHg062YoY
	 tkvzvGyErh9aX0B2trvImau1X2roKGa8lBcXp+KToOuwa8ieQ5HHkWNABhPQylBuCcAbN
	 ZI4hODcOImw2paVZ/R1+4qWYiF4dI3jHz8YzXKCxV0ZqJqdf75RPz3X/+2Q4jDRxK7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TKl1Fpo0;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E1606D6B3
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814E1606D6B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TKl1Fpo0
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed08b07232so8196145ad.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577934; x=1795182734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
        b=TKl1Fpo09aGy2X/6g4rqWMCDe6yRsGaCn4ziqqMCt/0BCllTEK/txyF3L+0dqyNWoz
         5Od1dnzxNCQwBS8yxStc6Dq1GcvuI6UEk4Hz/hDG8HdhemvzD2ZpS2Ahjaz5Ct1n9uYy
         eo4xcF+LWNWzWMMKinYUDIT2hG4FZ6FYvdm9oc8mK62op1pxfBXjX7tfJk8krceQYyXI
         iMCjPO15xuUmL4/iZvf8rvSS3pp2FMKWpSOEPzGx6/w5ODk7vyIO0siRPUcts7X+6Wv0
         2pLEokDE8n1HY+Mj0PuxRg1JqaDpKeeG67RL5mUYgtVa7vLJRD34hMsFZmZ0KhkgSAnK
         qi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577934; x=1795182734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlPSuCq58e3P4npzO9nCJTYzKVXM26Cp2n+6yfohh6Y=;
        b=rKL8AUZsY6HR24Ok13yTLOoRVSqJHIlOFHYOdVJRsyAu1FgPdbZviblgRFaHXrDJVT
         AzpM6UVYQQhHJ6Y6vs1KKXu1ikrstl3yAF01Z7Qs75g34arA8MmV+iiX1XTtFMpdNKk0
         g6lFuja/RgHL7EJ6vOpr42Qw/lx1jowJttXP+0rSNdgsAMfW6cPPO8sFeMUdsG3yF/hW
         Z+LzkKyn0/8zJxgdDHebAf5Q5kGmKtrBgI4RC4kaiFc6a0QmrrUkYfDDoog8x6AJuT4m
         LBdPiehGrTuumtqZhDf4+gL9pMVnmCspTtG9xSLP7Y23QK3u7bOIuZffCDdUvCWyo6HS
         j3zw==
X-Forwarded-Encrypted: i=1; AL+hErGYBORH1R9ds/JRtsrooXsKc30Gfy3COqBQhkNuj1fTzRIbKJS8BzRzWbussq8iCYFXsTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7zIsuxQX2CyXc5EjYyCpSrq0dWBKFZPpaholECDi3htUkffkh
	d4uVzQ1wOnXGUbKkLJP1wLNWp+3YLR3HTs6JgAzj5/PLpyTXfvOjsulNOMiCgzAWkjnNGDtKOeY
	lJJpr7g==
X-Received: from plly20.prod.google.com ([2002:a17:902:7c94:b0:2e9:4ce7:154a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da86:b0:2ed:1fb0:7784
 with SMTP id d9443c01a7336-2ee0da7bd5fmr24791955ad.10.1794577933550; Fri, 13
 Nov 2026 05:52:13 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:27 -0800
In-Reply-To: <20261005192431.87317-1-hmushi@amazon.co.uk>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441831766.81610.17390734527567827315.b4-ty@b4>
Subject: Re: [PATCH 0/3] KVM: x86: Support hibernation of a nested Hyper-V
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Mushahid Hussain <hmushi@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, 05 Oct 2026 19:24:28 +0000, Mushahid Hussain wrote:
> A Windows guest with the Hyper-V role enabled runs its own hypervisor
> (hvix64) nested under KVM. When KVM advertises the Hyper-V time and
> frequency MSRs, hvix64 lets KVM own the partition reference time. It
> then offers hibernation to Windows only if KVM also advertises CPUID
> 0x40000004 EAX bit 20 (RestoreTimeOnResume), and on resume restores
> the saved TSC and reference time through HvCallRestorePartitionTime
> (0x103). Both are reserved in the TLFS and defined in Microsoft's
> hvdef crate.
> 
> [...]

Applied patch 1 to kvm-x86 vmx, thanks!

[1/3] KVM: nVMX: Clear stale vmcs02 sync flag in free_nested()
      https://github.com/kvm-x86/linux/commit/ef289f270c59

--
https://github.com/kvm-x86/linux/tree/next
