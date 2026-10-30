Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369762;
	b=CuoaUbAizQywET+xzmpqu3mu6X7u+L/b1VRxICqVC1YQBQk2x7RUGuR6fkXV2vYI9GnC
	 UowASUJbB4rv46V9dPHbdL9sn8UB9mF2RzsOyK/4Yi+B0UgBi/lXMol6ZHYNAZZY9h1Es
	 nkyYFzI/hxxwyafFN7qdOAhMKpAXJH9jmw8U5quVCB89QSvaD91NODmDLq6qS6DO7eYMc
	 BmvaqckaisA7SGTo8GBZSr9qgJ2tE8dlfasgH5RkOj1CstAlRQaVcSEv4jMjUCXazYPEP
	 WubqAUDDWZmy8dyFCx31v6mElB2xdYSWE+JKXd9oj4sRy2stRkpPvs4nuaaEmFOHIpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369762;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=U3mh0uWcEKmF6rz6g3nv0SX0Dkn3wPP6PAyrpn5THiI=;
	b=BoQDbPk9qFFFenusz0LmEUkReYoAlQ8Qf0tEYGS8MKGGOfObSwDDnPCPE3I91ajOgU35
	 ix23OYT89sI8rYq52Cl8wjcfM6/x0UfNSi/zyCZoFGXjI5931VKhWv780wacniDnQWC+N
	 U1oVGwwOGtrnmldVqgdEoqLkvJ4bhG2ki9QtKucE80Tb7YdAJEAEasX391+dNpHdRaKw2
	 6LcXXdP61Ih0AqfUp9tXgU7+zj54uyb/fQ9uEF88oMxNV1Gdvmdp3iAheo8D5PfJztJKU
	 izQAT5jgxKgr3qUhhlJ+oea/S+GG9rJxcT70vUmLlArGT8Xj9lZRllMz0OeMPvFG+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dutMwEYA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55933606A31C;
	Fri, 30 Oct 2026 14:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55933606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dutMwEYA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02F71F60;
	Fri, 30 Oct 2026 07:15:57 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7681D3F673;
	Fri, 30 Oct 2026 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793369761; bh=GgEd+PH/jbq28UuYqcwDbQX/UOZkQ32m5RYqOej8J8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dutMwEYAFpbCr/3XewPMFmB38iOS8ovV+p3UxpXzOGWbjtVHG7Al4HMwOz+NFMXD6
	 /aaaD3oKAX2aT2ycObpBXr5+dBEcYMgzJBnPS2YuS/IDD/LhqDW+hN3V+rSuTryn9i
	 bi+6s+GHCIUINFW1E+zM80eCwXTT1rVCtofpGbmg=
From: Leonardo Bras <leo.bras@arm.com>
To: Tian Zheng <zhengtian10@huawei.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	maz@kernel.org,
	oupton@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	pbonzini@redhat.com,
	yuzenghui@huawei.com,
	wangzhou1@hisilicon.com,
	yangjinqian1@huawei.com,
	caijian11@h-partners.com,
	liuyonglong@huawei.com,
	tangchengchang@huawei.com,
	yezhenyu2@huawei.com,
	yubihong@huawei.com,
	linuxarm@huawei.com,
	joey.gouly@arm.com,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	fuad.tabba@linux.dev,
	mark.rutland@arm.com,
	seanjc@google.com,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 06/15] KVM: arm64: Add support for FEAT_HDBSS
Date: Fri, 30 Oct 2026 14:15:51 +0000
Message-ID: <auSml6yTVYIQe7NZ@LeoBrasDK>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <a301e884-f6d1-4082-8551-8d8a17276dc3@huawei.com>
References: <20260929103655.85107-1-zhengtian10@huawei.com> <20260929103655.85107-7-zhengtian10@huawei.com> <at-X_hFbsBU_Dsgr@LeoBrasDK> <a301e884-f6d1-4082-8551-8d8a17276dc3@huawei.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 30, 2026 at 10:53:57AM +0800, Tian Zheng wrote:
> 
> 
> On 10/27/2026 2:12 AM, Leonardo Bras wrote:
> > On Tue, Sep 29, 2026 at 06:36:46PM +0800, Tian Zheng wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 32102c3912fa..12fa37328dd2 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2158,6 +2158,11 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> > >   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> > >   }
> > > 
> > > +static bool has_vhe_hdbss(const struct arm64_cpu_capabilities *entry, int scope)
> > > +{
> > > +	return is_kernel_in_hyp_mode() && has_cpuid_feature(entry, scope);
> > > +}
> > > +
> > 
> 
> Hi leo,
> 
> > IIUC you run this on every cpu in the system, to make sure it's matching
> > the feature. Is there any chance the kernel is in EL2 only on some of the
> > cpus here?
> > 
> 
> It's impossible for the system to have only some CPUs in EL2 and others
>  not.
> 
> > If not, maybe we can run it on system_supports_hdbss() instead, which would
> > be easier for the user to understand it only runs in EL2, on top of not
> > needing the above.
> > 
> 
> However, The question is whether a cap should mean "this system can use
> the feature" or "this hardware supports the feature". If the cap only
> tracks hardware support, users may be confused when the hardware
> supports HDBSS but the system runs in nVHE mode — they would mistakenly
> believe they can use the feature.
> 
> So I think we should keep is_kernel_in_hyp_mode() in has_vhe_hdbss(),
> and add a comment in system_supports_hdbss() explaining this.
> 
> Does that work for you? Looking forward to your reply.

Well, 
That's just my personal view of this:

If we have a function called "has_hdbss" it should only report if the 
system has the feature available.

On the "system_supports_*" we have to figure out if the system itself 
supports the feature, which checks the feature bits itself and could mean 
checking for other features being there, such as hyp_mode.  

What do you think?

Thx,
Leo
