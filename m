Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210331;
	b=DkFDC8WgcjaGQXyqL3Ws9Xkefs1bAk0oZw1/jOBbZf+3LVaAmW2qPilYyukOzF4y/C/l
	 KVPdkshqNO43KUinHOulacf0MNSuyF5GM3HOMWB4m0navgDIpg7hZcpTqOyFx5e73q/yf
	 QmNZVOwjFMLRiEyaPG/FtZRp0Elbdnzej2OVThhu0F2Vxltr6mVL5Ix5kqM89nKlqqVz/
	 9C4RmUhoofgG4tjh/Y1/uwSc4s0LdIYtOTA4SuzHbLEQASeVp13yv71QBFLHNnqIQVdXX
	 QX3Gtq6r7+MYHkIcia6s53GrpK/IP0YvBsAeTW0EqXkp0Rdw1d7CfqaPKmOoweL7AXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210331;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=z9x0NO7zlXp/7FYiEEYfryJ5lKhGAhIxkcRFLTLWHCA=;
	b=TQNHz2dzP7WZUSyPrS1nusx22Cc0qi1HX3s+XH1kKrUMqTUjitQ7HXWVPBDu0mtpXAdH
	 mvIZ0e0ZygiJkOCrl8X/QfPnVEqcwmgnIgSa0/qsZjaSzY6QazytCnoLxh47jxX3CsjZ6
	 TtQi0XAhaqKezvWcrpBgY92d8uvgGvvRQKX0LNjW+VKbMhCIwmxlUA8A2nxtDGUwc7ceQ
	 hLxdOIFGMaAprWP5t2AplI6hyVLl0maLhUb/cacAK/9vBTDkESLXhBA88Gpul6b8dIrm6
	 fFwsIK49hbOobXfijgP3M3ZrFdweE2Rgu6Z9LF4wP5zIQJKFwSTMWvHsenbuFhNMjEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGvy5Ghc;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEA606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 07:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7DEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGvy5Ghc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794210330; x=1825746330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XN8LJJcBeJ8NO2WVvljzmuzA89fcGQ+LSPvL3RgdHgI=;
  b=lGvy5GhcLtW7msGxW0c3imtaDo9S7Htx7AceohQGXhD0XoUkba9LwTBl
   sSY4CZ55ak+ccrhXoGdwVPol/PBARGi6JF65xiBgfcrcuhZh7BLxAEVa0
   LP1CMnk/6btmJl+kerFISwASs5yJhDa6dg6i7xY+z9sQDEkte+zJwhVhj
   XDZbelgl1UTMDw7KNpirfS7FjyNLTReQ0WApCIRmkARvc8p8rZxoLBWYa
   c1907uJo8pHNDAM8yVKgO4OkpfUsd29m45ptbLrelu9wXiVYS1bmLScLc
   JWlMnOJ6Roud3Ai5jIb7cafdHIiWd4VaSi/UlAU2h7w5K3I5gvvctTxLV
   A==;
X-CSE-ConnectionGUID: 9VWpJauLRGW/dBA+Cb6H3w==
X-CSE-MsgGUID: uDLXVPz4SvmkVDmaWO1V2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2806116"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2806116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:45:29 -0800
X-CSE-ConnectionGUID: V1yP/jTsRhaI65qoKEAosw==
X-CSE-MsgGUID: isseaBo+TbCTqz4DbN8FSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8144247"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.211])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:45:21 -0800
Date: Mon, 9 Nov 2026 09:45:17 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	"Serge Hallyn (AMD)" <sergeh@kernel.org>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	David.Kaplan@amd.com, Mathias.Brossard@arm.com
Subject: Re: TDX migration model
Message-ID: <avF6DcmdoGeWeRxg@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
 <auyZnIfxMnxYD8rT@shallyn-amd>
 <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
 <auyx8C67zCnbPpuL@hallyn.com>
 <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>
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
In-Reply-To: <c77156d1-5a47-4a93-a18b-392081fad3ff@intel.com>

On Thu, Nov 05, 2026 at 06:00:41PM -0800, Kishen Maloor wrote:
> On 11/5/26 8:42 AM, Serge E. Hallyn wrote:
> > On Thu, Nov 05, 2026 at 05:59:01PM +0200, Artem Bityutskiy wrote:
> >> On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> >>> ...
> >>> So, looking at the section '### How the Setup Session Works', is it safe
> >>> to assume that you are using the qemu migration fd for the message
> >>> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> >>> ...
> >> Yes, that's the flow. I’m not sure about the migration fd part, I believe we
> >> pass the setup session data via ioctl buffers. I am sure Kishen will can
> >> clarify.
> > 
> > If you mean pass via ioctl buffers from tdx->kvm-> back to qemu, which passes
> > it over the migration fd to the other side, then that's what I expected.
> > Othewise I'll be interested to the details :)
> 
> Hi Serge,
> 
> Your understanding is right. Migration setup requires a handshake of some sort
> between the source and destination. So the messages KVM_MIGRATE_SETUP returns
> are transferred over QEMU's migration channel to the other side and processed
> by a matching call.

Serge, on the QEMU side, we have been enabling the return-path early for
the key exchange before migration is active. Not sure if the key exchange
can be done using a VMState, possibly could be if we can ensure it happens
before the migration is active.

For the migration related commands, looks like we can just make the
KVM_EXPORT_CMD and KVM_IMPORT_CMD subcommands a bit more finer grained and
then drop the vendor flags until needed:

#define KVM_MIGRATE_EXCHANGE_KEYS	0 (New, was KVM_MIGRATE_SETUP and a flag)
#define KVM_MIGRATE_SETUP		1 (Migrates the immutable state)
#define KVM_MIGRATE_ITERATION		2 (Start a new pre-copy round)
#define KVM_MIGRATE_ITERATION_FINAL	3 (New, last pre-copy round before pause)
#define KVM_MIGRATE_PAUSE		4 (New, split from old STOP_AND_COPY)
#define KVM_MIGRATE_MUTABLE_STATE	5 (New, split from old STOP_AND_COPY)
#define KVM_MIGRATE_START_DESTINATION	6 (New, split from old STOP_AND_COPY)
#define KVM_MIGRATE_START_POSTCOPY	7 (New, could return -EOPNOTSUPP for now?)
#define KVM_MIGRATE_ABORT		8
#define KVM_MIGRATE_END			9

For the above PAUSE is four the source only. START_DESTINATION is for both
source and destination as source exports a start token for the destination.
START_POSTCOPY is not implemented but would be destination only when
implemented. ABORT is allowed at any point.

Any other subcommands needed at this point?

Then for handling the results, the following seems to simplify things a bit:

- Results are copied back only on success, vendor error is returned as is

- Import is all or nothing, vendor code resumes on interruptions

- For memory transfer, a GFN can only be transferred once per round,
  duplicate import attempt returns -EINVAL

Regards,

Tony
