Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846B21A434
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834314; cv=none; b=D56d4LkjAs7dCpg9l9NlY7tpufWbwFSIu6/l8qYcexHBpf9i8HQxtkOkIUXTEtf2c+HurEmUcLk16O+5pgHrAuZ+dc9lf9IsWXb8dVT/u/mn9ks5vruILWZ6FyDP1ArIzOvYtcFdRVvtc/Yp3lK+1KqjVK8NObiL3hCsCfjdJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834314; c=relaxed/simple;
	bh=+zNOMXJD5XtvBS1QGG2L/uqrzl5jpIUasRZpOO3HbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnMVamcGTa7Pf06NyhFf1UhJHeFUXPodSVyydXMQ+TLd/xvIPK32zm4B8l+NKbdujzfZY8+xednaV+9PjP/lX+xuVaTMaVZMH14ddV7UROv2JcIRYg7UZdBIX74C4aAZTpildnRBz/xvknF2qcfyLWweDKWuU60jjTHDuKGHxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=N2yXbIdT; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="N2yXbIdT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1787834312; x=1819370312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zNOMXJD5XtvBS1QGG2L/uqrzl5jpIUasRZpOO3HbiQ=;
  b=N2yXbIdTI6vCA3WkL73sCE+uVp0A1TZfGqW8cca41smAQb6gUUg/GYoE
   UtVj9sb3/7/ZHbv/Cej1wrTqzPY4ySTgCb7CXUu8FCicCeC8hVL9vF4Nu
   799vpx8OMJnWa4bYNpmJyOb0hq3aIBz6fw0YkPMc7MytHipIaxLWpaMbh
   uo1+EHeglNOU38L8nafo3pzzMORDXKj4XdHcznWrNiVkLEu0nQ7AZQF4B
   e/oDifqExbN7yLzQ6R4XtAiuEOmSaP32AyaTZv063MIMFFoEAw6zKQ1EF
   f4Ufo84XSNgFZhn0z7tpaZuRgPqvSRa1ZFcHh5Z5bZUENBVo+W4Ahm/mv
   A==;
X-CSE-ConnectionGUID: UE4cPUCJQMewhjEMSdJRoA==
X-CSE-MsgGUID: NGtXd7B0TAq0fXy7wkESVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="231780978"
X-IronPort-AV: E=Sophos;i="6.25,246,1779116400"; 
   d="scan'208";a="231780978"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:38:25 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 654D6820C38
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:38:25 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 1C2788D65DC
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:38:25 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.202.6])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with SMTP id 729FC180219D;
	Thu, 27 Aug 2026 12:38:19 +0000 (UTC)
Date: Thu, 27 Aug 2026 21:38:17 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <apAs7L1-QBOTUNtH@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
 <ao4Eetq7oAAsipo4@p14s>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ao4Eetq7oAAsipo4@p14s>

On 08/25 15:09, Mathieu Poirier wrote:
> Hi Kohei - apologies for the delayed reply.
> 
> On Thu, Jul 30, 2026 at 02:11:57PM +0900, Kohei Enju wrote:
> > On 07/28 13:26, Mathieu Poirier wrote:
> > > This patchset provides minimal functionality to start a Realm VM
> > > from an Arm RME capable host using the following command line:
> > > 
> > > qemu-system-aarch64 \
> > >  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
> > >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > > 
> > > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > > back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> > > CCA support to KVM.
> > > 
> > > * We are currently working on rebasing the work to v15.
> > > 
> > > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > > here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> > > machine (compatible with Steven's v14 patchset).
> > > 
> > > Instructions to compile and run the entire stack can be found here [6].
> > > 
> > > Device Assignment is not included.
> > > 
> > > Thanks,
> > > Mathieu
> > 
> > Hi Mathieu, thank you for your work on upstreaming CCA support. I've
> > tested this series in QEMU-TCG(x-rme=on) environments and confirmed
> > that the basic functionality works well.
> > 
> > I have a question about a QMP command for querying CCA capabilities.
> > 
> > Jean's tree contains the following commit adding such a QMP command. Was
> > this functionality intentionally omitted from this series?
> > https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12
> >
> 
> git.codelinaro.org is no longer accessible to me.  Please see if you can point
> me to the same patch in this repository:
> 
> https://gitlab.com/Linaro/cca-public/qemu/-/commits/cca/2025-09-12?ref_type=heads

Hi, thank you for taking a look.

I checked the repository, but could not find the corresponding patch
there. If you agree, I would be happy to share a version of that patch,
updated as needed and rebased onto the latest v3 series.

Thanks,
Kohei

> 
>  
> > We are interested in adding this functionality because we are also
> > planning to upstream CCA support for libvirt, which will need a QMP
> > interface to query the CCA capabilities exposed by QEMU.
> > 
> > Since the Linux kernel dropped some configuration parameters such as the
> > hash algorithm, I need to rework the implementation of that QMP command
> > a bit. If it's okay with you, I'd be happy to send out the reworked
> > patch based on this series.
> > 
> > Thanks,
> > Kohei
> > 
