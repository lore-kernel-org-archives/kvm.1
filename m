Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC33A641D
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854151; cv=none; b=RCkKecvswuK0TYOmgG1DbOMX/M5U7O9jZW053/PGu7V2tUspCfj4g5k47dq6GRB8gA0BeRi3BL135vRz+XeFZdhF5HkrPQ9vSKGASDbNI6Ah8TvmVVSpURo8USahaV+VUWXFVt8D6i+ynK8q/ii+BH7Pn/Td5lDQm97AT9IkrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854151; c=relaxed/simple;
	bh=r4hdO+l1tHybJlhIhjw+zD0e2eT2sYv8x5tSfI6vj+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzVLr49AzKHLG9EC4b86i7nrUoiRQXpdjS7Xgk1d6NOI/1BPPIYVkrmIP33uRqH8DC5cFteM0kZrEi7kuTdmc60I/3SZVIyhjQ2PsFa7b1VUBiiksBZpG7biS5xJXp3ukc/9ai8/HKBExuJ1C/yj57g4MVEXTRdFC8CI+o2NSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H65+t3zd; arc=none smtp.client-ip=91.218.175.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H65+t3zd"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r4hdO+l1tHybJlhIhjw+zD0e2eT2sYv8x5tSfI6vj+8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788854148; v=1; x=1789458948;
 b=H65+t3zdyFsjaVqT1z3rHIrKrBGXyVsIr1mi6jj9FhCbe/FZCzRewCJWJ3XEgFrRxBX66Mq9
 WDE1NIeoiQJBF7LbZhuPv8J7hWc7B4xhzGaTBpEEDwm4nJfilShPhiijYqI43keGqj47WJMaC2O
 zt2D4yhVWpm/tfYSprdJ1C4A=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e7a79d9170bf2be;
	Tue, 08 Sep 2026 07:55:48 +0000
X-Mizu-Trace-ID: 0e7a79d9170bf2be
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17359so14174e87.0
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 00:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLWr1c7s8iiuA8FgE++3Nn003Q66wrtrQyJwltcusxiGNpb3IyBpd3+bB09+gDZnw4Da4=@vger.kernel.org
X-Gm-Message-State: AFuF++kwPOHxYJba8LFukEj6JcVmUkAH67YUKYflnZSc5U0rrqZBNc8p
	7IATU4c3+RFzyo7Bmobs7cXT7zdDybo60t6f697YGWkzNo5s0WMtTHSykKzaOCxeW5FxtaGClKg
	vs7sA1EtsBL4+DIc/FtmXNSp5qspxYvYyEYBG9E0b
X-Received: by 2002:a05:6512:3185:b0:5b6:19c6:a91b with SMTP id
 2adb3069b0e04-5b74d1e0c5bmr294833e87.14.1788854142874; Tue, 08 Sep 2026
 00:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
 <CA+EHjTwPmwPTMcgQB6zt47Kz6NPMr+FkGfq2Qq+Uxu+G427OEg@mail.gmail.com> <ap9wgBjYEDI-27N1@sm-arm-grace07>
In-Reply-To: <ap9wgBjYEDI-27N1@sm-arm-grace07>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 8 Sep 2026 08:55:06 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxy3vURKpjmcX86T+coXZN7sCfW=5L4TM3GH30xuz+zPA@mail.gmail.com>
X-Gm-Features: AcwNN1UPBjEuQQThxfaCHXl31wDDjpU8d24LqbsGJMyA-76vtr69g4waCdr9dow
Message-ID: <CA+EHjTxy3vURKpjmcX86T+coXZN7sCfW=5L4TM3GH30xuz+zPA@mail.gmail.com>
Subject: Re: [PATCH 0/2] 52-bit VA guest mode ID support
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Takayuki Okamoto <tokamoto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Itaru,

On Tue, 8 Sept 2026 at 03:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
>
> Hi Fuad,
> On Fri, Sep 04, 2026 at 09:14:36AM +0100, Fuad Tabba wrote:
> > On Tue, 25 Aug 2026 at 22:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
> > >
> > > This patch series extends the arm64 KVM selftest framework
> > > to support 52-bit guest virtual address (VA) modes in addition to
> > > the existing 52-bit physical address (PA) configurations.
> > > The motivation is to enable validation of LPA2 guest memory-management
> > > behaviour in configurations that use a 52-bit VA space.
> > > While the selftest framework already supports testing 52-bit PA
> > > configurations, it lacks the ability to exercise guests running with
> > > 52-bit virtual addresses, leaving part of the LPA2 functionality untested.
> >
> > The series adds three 52-bit VA guest modes, but nothing in tree maps
> > a guest VA high enough to use them. The mode-iterating tests map at a
> > fixed low GVA, so pgd_index() returns 0 and only the first entry of
> > the top level is ever used.
> >
> > What do you expect the modes to catch as they stand? The allocators
> > already take a minimum GVA, so mapping high in one of those tests
> > looks like a small change.
>
> I think at least a 4KB page is allocated for the level -1 translation table,
> and entry 0 is populated with a Table descriptor pointing to the level 0 translation
> table. But, no it does not test a nonzero top-level index.

Right, that's the gap. Every mode-iterating test maps at a fixed low
GVA (0xc0000000), so the new modes only ever fill entry 0 of the top
table. If the series adds the modes, it should add a test that drives
a VA into the 52-bit range.

> >
> > > To address this, the series introduces new guest modes for 52-bit VA
> > > operation, adds five-level page table support where required, and
> > > performs runtime detection of host 52-bit VA capability so that
> > > LPA2-enabled guest VA tests are executed only on supported systems.
> > >
> > > Testing:
> > >
> > > Built and tested on arm64.
> > > Verified on QEMU with a V52-capable guest configuration.
> > > Confirmed correct operation of high virtual address mappings by
> > > exercising guest memory accesses in the 52-bit VA range.
> >
> > I could not reproduce "exercising guest memory accesses in the 52-bit
> > VA range" with anything in tree either. Could you say which test you
> > ran, which guest modes, and on what?
>
> I just in guest_code() of existing one of the kselftests, mapped and
> accessed a page at 1ULL << 49 using virt_pg_map() and on QEMU TCG mode
> as I don't currently have access to the machines LPA and LPA2 features.

That test is what the series needs, and you've already written it.
Folding a mode-iterating version in tree would exercise the modes and
make the cover letter's "52-bit VA range" line reproducible. It runs
under TCG, so no LPA2 hardware needed.

Cheers,
/fuad

> Thanks,
> Itaru.
> >
> > Thanks,
> > /fuad
> >
> > > Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> > > Reviewed-by: Takayuki Okamoto <tokamoto@fujitsu.com>
> > > ---
> > > Itaru Kitayama (2):
> > >       KVM: selftest: arm64: Support 5-level paging in stage 1 translation table
> > >       KVM: selftests: arm64: Add 52-bit VA guest modes
> > >
> > >  .../selftests/kvm/include/arm64/processor.h        |  2 +
> > >  tools/testing/selftests/kvm/include/kvm_util.h     |  3 +
> > >  tools/testing/selftests/kvm/lib/arm64/processor.c  | 87 ++++++++++++++++++++--
> > >  tools/testing/selftests/kvm/lib/guest_modes.c      |  5 ++
> > >  tools/testing/selftests/kvm/lib/kvm_util.c         | 11 +++
> > >  5 files changed, 103 insertions(+), 5 deletions(-)
> > > ---
> > > base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> > > change-id: 20260825-arm64-52bit-va-32f1f4cd050d
> > >
> > > Best regards,
> > > --
> > > Itaru Kitayama <itaru.kitayama@fujitsu.com>
> > >
