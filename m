Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A630E858
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178312; cv=none; b=QHypIAYSC/5Glh0badTF+X6HgMPRIDDjyJxbt9zeDmKJYVtY+kEh6BIuhD8uLyU32/38A3JiHCg2SnXptBEIF6h4X1RW/2Hhyz3LZbsrPLlbJTME9mXrTEs0CZIhzkgEEYj0SZDJMIEg/lfhRiHB1h+5NWwoUcRLRYKzgxsww3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178312; c=relaxed/simple;
	bh=POxxjDSxZlHQfyZkrcAnx7XWj0an4MkT8ArD9j0Rkcg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Bz0DCp+PIDqbNHkgdpHIbMYMNx98tyf+XMtSPluidgAEoF9by428Opa++06J1+MzeTqq9Drhf3V6QRpzcxI+PFkEQh+D+kQa928y6Wshm6G94kZK8H0J5ZiraecFGl5EX+0/WyCzl8HHIvGGs0boqH9Go1OcN+CTz7PvuGZGfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHxErgMp; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHxErgMp"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso919697eec.3
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 22:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178310; x=1791783110; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cIbXE6R67m8wmmcQnF+5IRKqUHaCj3Oi7gyWQv3055A=;
        b=tHxErgMp9X5jGre1UVi3mM0MUN0Rpc1PNllHJYmRU4hEXHbRLeozT1gqMTittgT31W
         x2sg52MuGMRThqItgnahcV6IQ0aqPViMwrS6EaYSaQrNNq/DeY1NyiwTxDZdiPeIDs8d
         8RmGfttr0gTc6sU2RVbhFmgxz143RfivFeGB+Izev0X4/aJ3rN3r9iMLSMBiJbW4BPSM
         UYxdCKYTcjMp+JqF+rlb354/0m3ieqn3bT8UuWBFQQlFC4dOHa5lmP3YoGkzC+aCjtEm
         VlNv0gEwLoBfi92LaETkFOE2f36zmw+4kuRp3tsJAIfdVdy73OJz/5LRVEgMYinMUA5E
         KS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178310; x=1791783110;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIbXE6R67m8wmmcQnF+5IRKqUHaCj3Oi7gyWQv3055A=;
        b=27Wn+P6dREsYgQAI8vkbJ7KlvEUG2IL3wdsGkP/cb1KLjKxb3uP1mZnrI2joNa9F0S
         T5oNlTKQAwPi4JEsVYsCcdQC3JBmZH7MKcwgsZmck81pATXoAkHMxYPxwDI8MYWSv+Nz
         C43Qw5tZKlSrMLeYnQGjnCgpw32ERUUXRiU6XYhZ5vnLy+cJRdzp8wqwFqIUh69m8qtu
         /vnehih8USzINT/QZ/YPTv+65JJS5fWVL4wwn3Cjsz2lijWnLBZeN+A0g+uHOryD8ocu
         fCj3jWdYj9PgenTA6ySoIYk6uLIPf2TS+5fvQCDMqXeS8sKByYbUMgX1g++yubH+5Kvv
         fLHQ==
X-Gm-Message-State: AFuF++ny2QrIoV+ILTkXPjws5Za9ZfbjkqgNLGKuMWWnH3flIimtvuUj
	s3QSEzB4Pmuyy4tGKy+l8+vqXz/FGllUa+qHaLa+WsP9cCXEf2YRUTT/
X-Gm-Gg: AYBFou1nmnOHcy5/kyF4e9rfMJeu7fTIc9bEwKE22DlRm8W05EnlCOaMJTR+2OwHJTV
	xf2qwDHAnaE8/G/ZotNhIu5Fq7RKQoNq70ADARsmF6hl+fvpUhgn0p3EfNv5ABwbW//6chXr9Uh
	GiGNGtbxYW6ggmuUC0lP5bbSBmj5FbifCQKlEV0PZW2zVjvcI+quCgIVsq7Ymn5mA1alodqAtBP
	CsvLCxPwdosZJXzkLiIyLvoHLSETQqOrznwPGnwXWPqrvhYH5+J80+DIeq/eksWssgEmCeE0iqm
	PbME4KyYkH7KcAcP421DRHKiegVAoiFhzyVgNyZdZhJYLBnlkHt7jm4SKj0sBgYgc4QKhqyXyos
	tZNEHpS99NYiq4C4VU6e3Y+TYxngGHdvKu6I6s0JlHhtaDdU71KD9/1oF1k2iBP8MKTxwzHueCm
	KPnGtJfEcH/21RUWtJ8eg99sEzAXlJubYKItZ/NvucWMYn2OPcfH8iLCe9SbIJ3UMhrYXkw44t6
	lKty74Xmkyz2owTsIbXG7vWg/H48bYend6etQ1vIBbStMrufqoZSDbb/II3zrUb
X-Received: by 2002:a05:693c:69c5:b0:34c:45da:9b5 with SMTP id 5a478bee46e88-34f150c28c4mr12369259eec.20.1791178309882;
        Sun, 04 Oct 2026 22:31:49 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351271612e9sm10257390eec.12.2026.10.04.22.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:31:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asMN_TAX-1_J3jiP@google.com>
Date: Mon, 05 Oct 2026 09:55:36 +0530
Message-ID: <fqykkc3j.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com> <asMN_TAX-1_J3jiP@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>


Hi Sean,

Sorry I didn't see this email before sending out v6.
I think we can ignore v6, once the discussion here is sorted - I can
share a v7.

Sean Christopherson <seanjc@google.com> writes:

> On Sat, Oct 03, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
>> kvm_create_max_vcpus
>
> Oh, right, kvm_create_max_vcpus is a common test.  Can userspace detect that it's
> running KVM-on-PowerVM (in a not completely unpleasant way)?  If so, an alternative
> would be to keep the KVM_CAP_PPC_SMT change in v6 (patch 2) as a prep patch (before
> adding PPC support to Makefile.kvm), and then add a
> TEST_REQUIRE(!kvm_is_on_ppc_powervm()) or whatever.
>

So stictly speaking there is no simple check like that - however, I
think we can skip the test when we are running on pseries LPAR (meaning
trying to run a nested guest). We already have the check
is_pseries_lpar() for access_tracking_perf_test. I think we can re-use
the same check here as well.

> I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
> over open coding TEST_GEN_PROGS_COMMON.

Sure, so will add this check for kvm_create_max_vcpus()

#ifdef __powerpc64__
       TEST_REQUIRE(!is_pseries_lpar());
#endif 


Actually I was thinking we may as well use the same check for now for
skipping hardware_disable_test on pseries. Because there also we suffer
from the same resource limitation. Let me know if that sounds ok to you
or do you want us to skip kvm_create_max_vcpus() only for now, since it
is part of TEST_GEN_PROGS_COMMON?

> LoongArch open coded its full test list
> for some reason, and in less than a year it has started missing out on new common
> tests.
>
>> (& maybe few others like vm_types_test) from that in v6.
>
> What's wrong with VM types test?  That one really should Just Work on all
> architectures.  It doesn't run on LoongArch, but I assume that's
> oversight?

So the test doesn't fail (it gets skipped). However this cap
"KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
open code all common tests, hence I thought I may as well not add this
in the first place.


BTW, based on this discussion, I think I will re-arrange the patches in
the following order and send a v7. (The Makefile.kvm changes will only
get added after the main patch which adds powerpc support).

cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested
178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc
11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x


Please let me know if this sounds ok?

-ritesh

