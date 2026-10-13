Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E7515970;
	Tue, 13 Oct 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907070; cv=none; b=uHTYVhvZhbc/15Y5DCkgmO5eyvSORzwnbgMr2Op/ottjDP+AFSyqwIPO+i7Vxvj/oqur8axwF1sS+Rmw/7/4YBtXIXLknG6BaVMAmW/O9z0++CJctPoF2pM/FM4N4yvsc3l9MisQjUQIRQgxnIdEXIQ3ZSZleLq3NHfxWzKGwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907070; c=relaxed/simple;
	bh=BmgPBft1Gui7lL5HNj3ekId/21AIbJJtYcfNQBDYfy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIkVOwHPZhmdkJMBE3bFWZXKKRZI5vVnWoqC3NWfjNYZCrhBsq0iCYaCbyXiDnqAn7XuuUR1auwAUHfAq3ZZw8+4lf6zniZQ44I7JgNAwHcBHMHuv4L4TlDc06Iyo4//VU4PayroVHB2oNIV7OEKvXg+X5CsHI10e2E71kSwmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L2uvIf2n; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L2uvIf2n"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4666C1650;
	Tue, 13 Oct 2026 08:57:45 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0C43F673;
	Tue, 13 Oct 2026 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791907068; bh=BmgPBft1Gui7lL5HNj3ekId/21AIbJJtYcfNQBDYfy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2uvIf2niOedfNr+LE8u9qeU+als8GL5sn6Fk+M/CRaWLhK8PQ2znJpimWKJLv/yd
	 +tTdLYlNH2gzYaMJc6Cxw6toOfO+oSrGE9RgNjvRUHg84XCogxrTaRIsFOuQo2Tonx
	 piT3fnXMwEWhPZenzeqH8AeABXyesoqVf5BlOhiM=
Message-ID: <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
Date: Tue, 13 Oct 2026 16:57:44 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de
Cc: x86@kernel.org, Dave.Martin@arm.com, james.morse@arm.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 10/10/2026 00:44, Babu Moger wrote:
> When the user switches counter assignment mode by writing "mbm_event" to
> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
> counters, resets per-domain RMID state, and enables counter auto-assignment
> exposed to user space as mbm_assign_on_mkdir.
> 
> Even though counter auto-assignment is enabled, groups that already exist
> at the time of the switch, including the default group created at mount,
> are not assigned a counter. All MBM events read "Unassigned" until the user
> assigns a counter by hand.
> 
> Walk every existing CTRL_MON and its MON children after the reset and
> assign counters to their MBM events. Enabling "mbm_event" now leaves the
> same per-group state that auto-assignment would have produced. There may be
> fewer available counters than MBM events across the existing groups; in
> that case stop assignment when no counters remain. Events in the remaining
> groups read "Unassigned", matching the behavior of creating a group when no
> counters are available. Also revise the rdtgroup_assign_cntrs() function
> comments to account for the new callers.
> 
> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> ---
> v4: Changelog update (Reinette's input).
>     Function comment update for rdtgroup_assign_cntrs().
> 
> v3: Changelog update.
>     Code comment cleanup.
>     Added Cc to stable.
>     Added Reported-by and Closes tags.
> 
> v2: New patch.
>     This patch addresses the Sashiko comment about documentation issue where
>     counters are not assigned automatically when mode is switched to mbm_event.
>     https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>     In fact, it exposed a real issue. When switching to mbm_event mode, existing
>     monitoring groups should be assigned counters whenever counters are available.
>     This provides a smooth transition between modes and aligns the behavior with
>     the existing auto-assignment mechanism.


Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
treating this as more of a general auto assignment should the assignment also be done when a resctrl
domain is brought back online.

For illustration on an MPAM model I see:

/sys/fs/resctrl# cat mbm_L3_assignments
mbm_total_bytes:2=e;3=e

# offline one domain
/sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
/sys/fs/resctrl# cat mbm_L3_assignments
mbm_total_bytes:3=e

# bring the domain back online
/sys/fs/resctrl# cat mbm_L3_assignments
mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?

Thanks,

Ben

