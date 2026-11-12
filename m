Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505356;
	b=G9UV4/jy1L8KQ+AFRuSBzD/rcxsUV5nOlu2a/NsD3InnAn25mrXLKBYy9/+Du9HToVEM
	 8j3nx3STkQ3X4CG7PfP12FhaZ53o6RfpwVg/AfC9dr0bp97y6+2lphM2aZEXCimmC7qM2
	 Iex7C7OipYe8xm9BdAY87U0DirvQl5ZE8DVFHbVxFRDCa3I0um+FYp7j8n6z7gxeh4SGj
	 oNsJnasY+KTa8gsv2/LuRJIKEER1RlOpZjcuPrA4d8uoDrwkZpqX3XbieuJLmH9ScC6Pp
	 7oNNw4ZrseuVS4zeJY0Xlyovp84fogu0AII6vUkZyR+djoDQp2Efsx3SM4zGJYy5t2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505356;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=dhhn+7b+E0uHrS+RfB6VPpH7GUzc/qwFeX5mWbYxz3o=;
	b=ecni/6fZ+A21RlvQzWPuycTa1riVKUlAnec3uvmHo6VAxMdcPlfdIkMMCPB/zD20x8DJ
	 SwdzcSg3dvwlpU43rqXwaK5yIr7sxgfnL+/rbI9ti/Mz4aLv51zQpF0+GgF2lEIUgPi5m
	 X3f3Ot8HRDMTzF5S1wXTkK3rd5gMJFrmw87+faxpc6boQFog8E8TUyUZ3tvmKAGmpzldQ
	 U3mq8HVIUVpTDGSS9Wjf4MmH1RqwB4EQ1hg/n2802oLVLqNQkTJjFN7xWa+LSiXWqE2XI
	 UAI1BQNfNiMcoVRSjzJuoNVWP9Wluex0YdNYsv6XU+hojLVwYyMmUCz+Ijn8zOXh5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AmUywf5c;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C778606A88D;
	Thu, 12 Nov 2026 17:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C778606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AmUywf5c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dhhn+7b+E0uHrS+RfB6VPpH7GUzc/qwFeX5mWbYxz3o=; b=AmUywf5cub6TGT7GkBFrjaIEnx
	VQ9jBElSsX7kqt1UOOgaFWPVwyiCVR2GVXdzRBQRTYe9Hp9BAoMr8VUeDV0vKDsFgeGJz0Y+AzyZ5
	HfGKy6St0LD8EBTWgfRy/dQtlMDlYIjv9/AbSAbaW+wfBr1DgtvCrlz4FdXCpADdVDZ5yZNdhv7mt
	KL7+QAynBdbvbaNp/9Mc4ehmo3eFFChstEfzlT5z7sVLMoCcjg58H9Mkek7XnLR80mE4AXXgBez4y
	JQvIXZ3VaszEfmZvLKAoz4Cw3Ld8ntjiJkWrNDwkSElK/j+hBHIPjxNnDwAc47mCKN9aAljSaUGZf
	K29Ey6wg==;
Received: from [69.196.88.181] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRYoh-0000000Ad1t-1Sec;
	Thu, 12 Nov 2026 17:42:32 +0000
Date: Thu, 12 Nov 2026 10:42:22 -0700
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anish Moorthy <amoorthy@google.com>, Shuah Khan <shuah@kernel.org>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_KVM=3A_selftests=3A_Drop_stale_exac?=
 =?US-ASCII?Q?t_flags_check_in_private=5Fmem=5Fkvm=5Fexits=5Ftest?=
User-Agent: K-9 Mail for Android
In-Reply-To: <avX13o0qRkidIwWo@google.com>
References: <20261112144220.30801-1-dwmw2@infradead.org> <avX13o0qRkidIwWo@google.com>
Message-ID: <B98231C0-1516-4781-9C31-3CEE9922C8A6@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 12 November 2026 10:22:38 GMT-07:00, Sean Christopherson <seanjc@google=
=2Ecom> wrote:
>On Thu, Nov 12, 2026, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> Commit 7d0afe669374 ("KVM: selftests: Take into account mixed memory
>> fault flags") relaxed the memory_fault=2Eflags checks so that they only
>> test for KVM_MEMORY_EXIT_FLAG_PRIVATE, since KVM may report the access
>> type alongside it=2E In test_private_access_memslot_deleted() it added
>> the relaxed check but left the exact match above it, and with the
>> READ flag now reported the test fails for me there:
>
>Ah, this is against kvm/kvm-memprot-v4=2E
>
>Paolo, what are your plans with that branch?  Sashiko had valid complaint=
s, e=2Eg=2E
>against patch 1[*], so I assume the branch won't be merged as-is=2E
>
>[*] https://lore=2Ekernel=2Eorg/all/sashiko-outbox-193903@kernel=2Eorg

Yeah, I have a whole ASCII art diagram for VSM of the various branches it =
depends on, all of which need to come together=2E

Not sure how it'll survive being pasted on my phone=2E=2E=2E

```
  *   e7bf7087c71e (vsm-v2, vsm2/rollup) Merge branch 'vsm2/translate-prob=
e-fix' into vsm2/rollup
  |\
  | * 2041e48469c9 (vsm2/translate-probe-fix) KVM: selftests: Add a test f=
or KVM_TRANSLATE write permission
  | * 11e4bc669f5a KVM: x86: Report the guest's write permission from KVM_=
TRANSLATE
  | * (base: v7=2E4-rc2)                                    =E2=86=90 post=
able =E2=84=962, [RFC]
  |
  * 711d67d9ee59 (vsm2/vsm-extras) =E2=8B=AF 10 EXTRA commits =E2=8B=AF
  |      TLB-flush-inhibit group [Nikolas=C3=975 + 1 ours], suspended-stat=
e,
  |      hugepage selftest [Mushahid], stats, KVM_TRANSLATE allowlist
  |
  * 45e6e98c313e (vsm2/vsm-min, tag: vsm2-min1) =E2=8B=AF 32 MIN commits =
=E2=8B=AF
  |      per-plane attrs =E2=86=92 TSC page =E2=86=92 TLB flush =E2=86=92 =
VTL call/return =E2=86=92
  |      forced entry =E2=86=92 SynIC/overlays =E2=86=92 intercepts =E2=86=
=92 SVM state =E2=86=92 selftests
  |      [29 dwmw, 2 Mushahid incl=2E folds, 1 Sriram]
  |
  *   2dba8e6aa231 Merge branch 'vsm2/hcall-exit' into vsm2/vsm-min
  |\
  | * ab78e5f86ef8 (vsm2/hcall-exit) KVM: selftests: Add Hyper-V hypercall=
 forwarding test
  | * b5db9e2e8a73 KVM: x86: hyper-v: Advertise XMM fast hypercall output
  | * 13c74a93fa3a KVM: x86: hyper-v: Let userspace fault a forwarded hype=
rcall
  | * 365758d0df84 KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
  | * (base: v7=2E4-rc2)                                    =E2=86=90 post=
able =E2=84=961
  |
  *   d834e6e32d45 Merge branch 'vsm2/memattrs' into vsm2/vsm-min
  |\
  | *   2fd5c2a710a2 (vsm2/memattrs) Merge 'kvm-memprot-v4' of kvm=2Egit
  | |\
  | | * =E2=8B=AF 45 commits, Paolo, verbatim =E2=8B=AF
  | |/
  | * (base: v7=2E4-rc2)
  |
  * 08140f5dfd94 (vsm2/planes-uapi) =E2=8B=AF 9 commits =E2=8B=AF
  |      KVM_CAP_PLANES opt-in, run-state ioctls, request fan-out,
  |      APICv inhibit, XCR0 sharing, selftests [8 dwmw, 1 Paolo-reworked]
  |
  * 52a6b958f643 (vsm2/planes-fixes) =E2=8B=AF 16 commits =E2=8B=AF
  |      s390 lkp fix first; Hyper-V init, allowlist, current_vcpu/IPIv,
  |      TSC matching, CPUID [13 dwmw, 3 Mushahid]
  |
  * ea638a7ede9e (vsm2/planes) =E2=8B=AF 60 commits, J=C3=B6rg, verbatim =
=E2=8B=AF
  |
  * (v7=2E4-rc2)

  parked, not merged anywhere:
  * de563700e7ed (vsm2/translate2) ours =C3=971 (squashed probe) on =E2=8B=
=AF Nikolas =C3=9716 =E2=8B=AF on vsm2/memattrs


```
