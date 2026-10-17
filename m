Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287519A288;
	Sat, 17 Oct 2026 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196031; cv=none; b=QgjZO2+I/oonRKM+W/BJ9hzSGrEeoY0AEDazyY9n5zmAG0/QPPm9YFNq8DjKI0zlurWV+H0iJpDHkya82z7YBYmbhv2JB8AgqZnk9dw23z2hN01qlXZGyUCZyu5RqsJxJC3gdzRD+wb8VOCPPR3HKZE79p0Ul3RF38O7UeVE+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196031; c=relaxed/simple;
	bh=Nu/FsE3AmX/cN4oLkmGctOnGxop4YsUif0pF8nWe6u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC4Z9ydrYK+i2MwUOck9uACRcQKtiIXF+X9ZeswoKjwaMCscOX4Ue1Y4R382sxEMLNzmh+E2q4FXQP3h6+U8VrugoJ1nka5ywivMS+s2U98Q/nbSkvWN5nemZlvIHU2yhkgRw7oKHSRb7Nigp+05/z/hO4aWKHuv+dQZHXE/h3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY9t1h7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY9t1h7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273FC1F000C4;
	Sat, 17 Oct 2026 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196029;
	bh=/+e/R7AdDKjvzahDJnG7vre1fEE4IH1KtoeKgdA6fbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kY9t1h7qFE8dQ2uMluKMSUEQ/bnwgl65tDcrQUKAamG7fS0yK2irepQ5nE19Du3n2
	 HnVj9qP6/csT1/PlJXp39gHRtGxpbFPr0vjG+uxPKgyLl51vUec5H+Vh30rzSgf9T3
	 IGia+7OU+sf16Q/ANIQLoqNOYWX+s7X22Qs+BhiOojFB714Y6SixhlzPkWHT05O57+
	 X0pVkfsIFus5z+BO/u7eZI4Yf2TC2A9KqakEKG9exlKadFJiS9HHhP2qfIT6/hwKAL
	 2Ea+WPGsFtc1HQyomaQTBLX2ER4HRnq/aDBCF5AoiRY5k3+XLRf5KpCMZxfYwHsw20
	 EwP1uq7SKsADw==
Date: Fri, 16 Oct 2026 17:13:47 -0700
From: Drew Fustini <fustini@kernel.org>
To: Babu Moger <babu.moger@amd.com>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, tony.luck@intel.com,
	reinette.chatre@intel.com, bp@alien8.de, ben.horgan@arm.com,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, fenghuay@nvidia.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, akpm@linux-foundation.org,
	rppt@kernel.org, dapeng1.mi@linux.intel.com, elver@google.com,
	enelsonmoore@gmail.com, jlayton@kernel.org, kuba@kernel.org,
	ebiggers@kernel.org, seanjc@google.com, ewanhai-oc@zhaoxin.com,
	binbin.wu@linux.intel.com, peterz@infradead.org,
	ashish.kalra@amd.com, superm1@kernel.org, chang.seok.bae@intel.com,
	prathyushi.nangia@amd.com, kim.phillips@amd.com,
	ackerleytng@google.com, elena.reshetova@intel.com,
	naveen@kernel.org, darwi@linutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, eranian@google.com, peternewman@google.com
Subject: Re: [PATCH v6 00/18] x86,fs/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
Message-ID: <atK9u7Wm6jYQdqfy@thelio>
References: <cover.1790867441.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790867441.git.babu.moger@amd.com>

On Thu, Oct 01, 2026 at 10:10:23AM -0500, Babu Moger wrote:
> 
> Hi All,
> 
> This series adds support for AMD's Privilege-Level Zero Association
> (PLZA) so kernel work can use a separate resource allocation and/or
> monitoring association from the user task, and wires it up through a
> small generic "kernel mode" (kmode) layer in fs/resctrl so future
> architectures can plug in without touching (hopefully) core resctrl.

Hi Babu,

Yunhui Cui (cc'd) recently proposed a RISC-V extension [1] with similar
functionality. It adds a new CSR with a RCID (like CLOSID) and MCID
(like RMID) to use when the cpu switches to the privilege level that the
kernel runs in (supervisor-mode in RISC-V terminology). The srmcfg_assoc
register is defined as:

    Bits      Field
    --------  --------
    11:0      RCID
    12        RCID_EN
    15:13     Reserved
    27:16     MCID
    28        MCID_EN
    30:29     Reserved
    31        ASSOC_EN

It is similar enough to PLZA that I believe that this series could work
for RISC-V. Hopefully Yunhui Cui can comment further.

Thanks,
Drew

[1] https://lists.riscv.org/g/tech-privileged/message/3088
