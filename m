Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746576;
	b=IhbOEUSxZ3wWO+FUc0iS8b/08YAf10JcGTccBa7tL6xdj042EZAGF4J2UURcLUfV60Oj
	 I/m/Uj17aEKbucAieMJwXrUN8xhg7jE5Ac9zytL0i1jC7jmajvLRyGoa8vqowBGkVcEbw
	 9nCc2LpP2239lmbpYPr9CSremZ5gGgLnkhj2JVfBKM2tmG0JUCuMaZWwTKUiUAfNNjQFo
	 8/fi6xbq865ZviAMUcP0kcFkt/l0LuWxIG+jmDiCSSmF3ESvDzXZ+IhfFro3Rn61jJSGe
	 Exei17PQhS+0YWAdQHgrg6JpBYJE8Qc6fFFpEL8jBTDGP9VNDQTpFDbRM8hFuRglOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746576;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=BPeNtzKdkjRk3yYLPGGWWs/Dmk7smFspz0pCOoXktR4=;
	b=yvwZw0/ZyBi+CAcnsF9HZZHrNtqPP9pNCOL19KhEB63x+VA1ADWAHxF+5O2wywp2bHPs
	 PogP3MMMA5ClJzvLNm/135wN39h1IAX6y0Ya5I6pXVYaWneuYGAU32/HwmVA6nZrctBMi
	 u9nn3mSOZJqq4Y8jQAb7otKxfyci4UY1spVZNHd53ENeS01Ds+VBUHP4Xz7ADP9b8sC9b
	 L4mP4mJs7MfzEKdtNwbnVi0qB9LTwIHmHV4Fa33D93bhBNOaMsLtTv8vLPV1mk4OwM0CZ
	 H/zEk+Vxb2TwEI6O1icm3e/Rx7f8GgsqjxZnoqRyKcricbJxDgWruDm45gVGGlXbVqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=bd6wny8Y;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E7606A31A;
	Fri, 23 Oct 2026 09:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF7E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=bd6wny8Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BPeNtzKdkjRk3yYLPGGWWs/Dmk7smFspz0pCOoXktR4=; b=bd6wny8YKGwvc+gfYRDfnd2bUT
	DmwaKghgKrH4dtaIiknXovMUuv+NyxFqJvNfU6nqDAiufJCC6X93Ijb/ULfy1Mi094Wh/BsssNXQl
	9ZdCZEWBQOlzyZoyqbI+lELp2K9Ke+NsyAt1llsWU8K34SdBcJIvGrxMNa+tqABpuDfW/MmZAvViA
	5XW8VgGjLybpWaFVJbiHfFIlgBQgg/4WZLgT+cPml+OZsblJQsXSzY3tBHJO4ixdSdkQ/BoHcFnHE
	nzZspBEdk+s9J90LEbjycmYfJsZ0ZqDMcuiZisSUS4OsFbtwB1gQPbdaMFpT3+3jeTN9SrQJgPCKq
	RJkvunwg==;
Received: from mailer.gwdg.de ([134.76.10.26]:35063)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKBHJ-00EUFJ-16;
	Fri, 23 Oct 2026 11:09:32 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKBHI-0004oX-2z;
	Fri, 23 Oct 2026 11:09:32 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 11:09:31 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <yosry@kernel.org>, <seanjc@google.com>
CC: <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jmattson@google.com>,
	<amirmohammad.eftekhar@cispa.de>
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02 on every nested VMRUN
Date: Fri, 23 Oct 2026 11:09:24 +0200
Message-ID: <20261023090924.9685-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <atqdBFgoztW0nhoC@google.com>
References: <atpGGKVAL3bAnmnk@google.com> <atqdBFgoztW0nhoC@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-05.um.gwdg.de (10.108.142.64) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

On Wed, Oct 22, 2026, Yosry Ahmed wrote:
> So this test case passing should be confirming my allegation that
> intercepts take precedence over VLS.

I could be missing something, but a hardware repro points the other way,
at least on this part (Zen 4, Ryzen 5 PRO 8500GE, mainline 7.3-rc3). The
L2 runs "vmload; cpuid", so the exit code says whether VMLOAD was
intercepted (SVM_EXIT_VMLOAD, 0x82) or virtualized and run on to the
cpuid (SVM_EXIT_CPUID, 0x72):

  - Single VMRUN, vmcb12 VLS off, L1 intercepting VMLOAD: 0x82. The
    intercept is honored, as expected.
  - VMRUN #1 enables VLS legitimately (0x72), then VMRUN #2 with vmcb12
    VLS=0 and L1 intercepting VMLOAD: still 0x72. 3/3.

The difference from nested_vmsave_vmload_test.c is that the test only
looks at a single VMRUN. On VMRUN #2 vmcb12 has VLS off, so
nested_vmcb_needs_vls_intercept() returns true and
nested_vmcb02_recalc_intercepts() sets INTERCEPT_VMLOAD/VMSAVE in vmcb02.
But vmcb02->control.misc_ctl2 still has the VLS enable bit from VMRUN #1,
since it is only ever OR-set and never cleared, so vmcb02 enters VMRUN #2
with both INTERCEPT_VMLOAD and VLS set and the CPU virtualizes VMLOAD
anyway. That is the dropped intercept.

So with both bits live in the same vmcb02, VLS wins over the intercept on
this hardware, which is why I think the stale bit is an actual
intercept-drop (an L1 that intercepts VMLOAD/VMSAVE for its own L2 loses
that intercept after it has used VLS even once) rather than only untidy
state.

I haven't managed to square that with your reading of the test, so it is
entirely possible I am wrong about the precedence. If it helps I can send
the reproducer, or dump vmcb02->control (the intercept bitmap plus
misc_ctl2) right before the VMRUN #2 that virtualizes VMLOAD, so we can
confirm both bits are set going in.

Thanks,
Amirmohammad
