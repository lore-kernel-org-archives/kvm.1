Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2A1A681E;
	Wed,  1 Jul 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865725; cv=none; b=U9Yrc2+ZglXhIx4uNJKW2HBWXfqwy3FeGe1d7B6Z9wmzQ1cUx2K4pt58ufMnQPZkT0ySIQkERvGaogUE5ZFLDlUAXcUtUOuS8AZqV4KB0SPcn8VrF+dsEtjixsn2o+M7P/l7xhLG3BT8FnS6NGg1KEDaqIsO1fUb0FFiFbEGCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865725; c=relaxed/simple;
	bh=aB08cRjgCiaCEvXvWRbPq4t3u73vHV96ryhqFrqpjdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAA43zsXlqC5bBJrJji8RBGC0470ln2D8MVUKFCmbnWunXpDDtmaN+SmluIzo/5M+yjg2K9q4VIjyJT4uBc0+fyfV9XM7khZ10ukiPE/bBOuLm3mOhCAJG2JAeVsuE8ObB5tePtSnrXGtouWh37du34sP3b/Kt/QRPPxkUjNank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lUM9UMMr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lUM9UMMr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E016F40E01D8;
	Wed,  1 Jul 2026 00:28:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gpF5eBSGKeUY; Wed,  1 Jul 2026 00:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782865709; bh=7D9Mg8gjZS3tBxpWch7jXOoZXcvZiXay1nG0KX3LmCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUM9UMMrXSSROYEsdDJyUMsMA2lfMCQ45/4hxwjGSp+8tZIAovc/222eiFowfgS6M
	 ljqVdpFSbPCUu8a3yJgBItMOTSNerfyRbH4/+UeaB1vSj7nZfB5wP+pY+UO1KTNUiB
	 rVW3nnZnsM4hNthJbSMw2CZ2Kfwz+mkC5t1OKN6+yWznbCCmj+XfUkUqUjpUJHjdlG
	 Avv6trlTFNlahTpuaQw+mB3mMyk/CemLe40EMVtHMcz0f5y1tyVifrdd7iCvPSBVmG
	 S/CWuGpf7le90FyiYi14J0cHQcCa06oatkr7TayOFYlTcCdNMgCWID4LGnh/kaKlfb
	 ycrZnQCKvSs4okdM2/tXz1oVVy7Ly7ZK1nWQRbBjbAyX61CxqgBJLCon3z8IImBxFr
	 1qrX+BwfcVS9d7BqP7xTIyfQJk7hRmBAc09tT2HSdOV3PojmXAvpusi/VFZwxYEEaS
	 /k7bOzQmpjp+bEQRtEMOFHFJ2ENSfomoSFPnQY5OUk5O6e1pO33tQyn54Hu4te40vw
	 EGZ5cDV/cKCsHJWBfRXb54bPa8kJ3vfOEdjion/lQVvhankwFZ+3Qo0NbyrEsOAggV
	 rhy9LJZ0SjpppG19jHwgoBWHm459U4U5hfJFdxo2vp+7YuiHpfqjR1VP8lZJOvwfT2
	 nmObN5eF5XCifMbcJSScs+fI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3DD6E40E0140;
	Wed,  1 Jul 2026 00:28:10 +0000 (UTC)
Date: Tue, 30 Jun 2026 17:28:07 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"tsyrulnikov.borys@gmail.com" <tsyrulnikov.borys@gmail.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
Message-ID: <20260701002807.GFakRfF-S64NzAEhGL@fat_crate.local>
References: <cover.1780584300.git.kas@kernel.org>
 <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
 <a038a3dabd917b0da28059fc7b0116996b099868.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a038a3dabd917b0da28059fc7b0116996b099868.camel@intel.com>

On Wed, Jul 01, 2026 at 12:06:33AM +0000, Edgecombe, Rick P wrote:
> We should probably ping Sean/Paolo to ack this if we want Dave to take it. Is it
> the plan?

Not before Sashiko comments have been addressed:

https://sashiko.dev/#/patchset/cover.1780584300.git.kas%40kernel.org

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
