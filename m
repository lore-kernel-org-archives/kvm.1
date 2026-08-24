Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941EF1A9F90;
	Mon, 24 Aug 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573818; cv=none; b=mu/aUJJOw/3ajScFR7jO6ESvIY0or0kkKpThQBSQ4ePhyspfmiMDJDhExGfxdVExkuy7o9Ij4btY/Kd1L8/6S8VhjPTGGB6lQqZb5bjr1sDX711UXcSJBsXyNJe863AvXQwUAtB4OT2ndJSGr9ffiZfw0i63GDx1TA5eGJdlS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573818; c=relaxed/simple;
	bh=fv26KJvzSC/D4S0hDB4EiFM3cNOlC1CniKIpsLgYyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoUl17TGUnxeubTXFqcFChOtesUQMNGV8xGXMnl1YTDv6F+CpwPWeYUxBBZKXPbWQtLBKQLNR4Ta31TnHs4kAF18NVawVwh+LqPcFfYJs62vmzyOPcGgjSTvGmS7uaB71zqlA1sgdEqM9UCCSlML8Yfyh25mIxg2SlhIThiGEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsTGr6Bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsTGr6Bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2405D1F00A3A;
	Mon, 24 Aug 2026 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787573817;
	bh=rO1JIY/JR8fQTf6EMxD6iEg2/IQs89gYCr6B9GDnJSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsTGr6BjZL8me1khGkCL4eLppOlDcVx6hGIEuPXkWZ68OwVPHJC35Dhwx60QjtFgA
	 NEWkF/uuG45nY4z0MV7i89jWqIQuFqljwjvUONOXoHbNMOVR0DBF8aeM+qGNljfX9E
	 YhFytWpK6YMVi2gahCw2F6T55cmMadlO4Qvma7Wb6S/4smW+wL2v+dr5dFqdr/TX2K
	 Ser99sOJEilx+lgT0YpxcgkjNkw6/awzQ+ChJaeAhnTLEvi44MjbRxPFoDyNGjmNuv
	 3ffYPamPsDP46QMZaGOus80elTTaJD50sQ+rEzmNMrpDLghs3gMBtYKGCk7hKWBJcu
	 35nzD2qfKf77w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 03F0F1980058;
	Mon, 24 Aug 2026 08:16:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 08:16:54 -0400
X-ME-Sender: <xms:MzaMaoAx3pv8QfOC3lvrMSwpt2qMCjNttT1jIN-6l1BHqH7wa8vpDg>
    <xme:MzaMapy0EP96tWUX7mQJRAPZ9ttxcjKGbpCPaFWciX4BpBF4rwcOVsh7_YQycv9oI
    G66DoWKlEO_0ImiJt-D20l1cBXCKZllHnniJwG-XweZhNFyCdzBFsc>
X-ME-Received: <xmr:MzaManyjkaIC-3H8Vi-9ype7h6STGc4J-d_W4uF-jVPezGH1uKrqyUIDVYs>
X-ME-Proxy-Cause: dmFkZTEjj4ReC66Y/EyJUuxhOgHhKHZBtdIET1jo4T/FwIUPTzTM64HpBSLzTDOZbSskKf
    0cPy++PwcAV9YW9Hg48bNnzlcdhLm4ESBgrSfPVO8d4Ribbi8O3K3kJrmsGtgDbh9hmdIg
    WYOt7BRptYu7AJA7OGJJJb7yglZbBxG3FRLH9r+i4fz9Y8dvYMdfZ8fqLpEVCk5PWmtOA/
    Xpt8ZlVHT9IgfSTHQl258dPGk9tuugCYzLZB3zOiJSuzclj1znPrxkrc1CwDYP6BvWl7kn
    56XeHUdkV9R+Z+IJbtZYOi1YLxuY8dbO8CDOZSod0d2yhlZWGkyDSzwZTyRt6ntUiRnbkt
    r0EjV3XJut/k/ju3HftkYOaj1C0d0tvpe4B+tmP6ok6WX58EGwSh4SFdGK7k1OlkP04wLW
    k2cU2cpHAkremfz06IHUEVWZ9XqTEQ5WLyZtXKR1Ba/msGVobqKcvMUY360IlaXhlWztys
    E1Kmt6PJUMNopPFYH8iQIDR4V/sbQ619ZZlHUAiO58PD8Nr0ypre1eGJvjmIg8ze6RCvWt
    HdKd4ZC181nG7hGKaBi2jjvjE/hj/9qMJedv2N9mdlaesB3VvOZc+DB9G+WBNcD9PCsE7p
    m1z8+40ETL54F6xU3ZM2OAuvp1Mig0uJor0Mt+VHN7Aa8lLNQHKy0Bd47hAw
X-ME-Proxy: <xmx:MzaMapg8JesLqVlrlyFim-NAZyYHjkCcxH_MWhv3Qas8WtbjoNZKvA>
    <xmx:MzaMagQJsDx2GXhaDOiZtkBZigGahHEzQpxIm--765QvTjAAEcO1IA>
    <xmx:MzaMapKN_OQjUEZ6h_yQX8m94quk3ug2w3I4loD6m0Hr-SXDGBuDAg>
    <xmx:MzaManN5ArJCv1KQdWSkyY8hFtocoPC85E6vnFmcsPDvFcOhhzLCqA>
    <xmx:MzaMarxPmieHbIHPfrr_6O84H5iSxdakO_sfiUp6qbctInVmVoBzwyC3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 08:16:50 -0400 (EDT)
Date: Mon, 24 Aug 2026 13:16:49 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Maloor, Kishen" <kishen.maloor@intel.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Fang, Peter" <peter.fang@intel.com>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 3/6] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aow0zU7mYdpaqBxk@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-4-yilun.xu@linux.intel.com>
 <aohsoZbDBZ8ZIYez@thinkstation>
 <da4cc53825da8edf29bdaaab8352e1fbb60eea15.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da4cc53825da8edf29bdaaab8352e1fbb60eea15.camel@intel.com>

On Fri, Aug 21, 2026 at 10:22:01PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-08-21 at 16:22 +0100, Kiryl Shutsemau wrote:
> > On Fri, Aug 21, 2026 at 11:29:17AM +0800, Xu Yilun wrote:
> > >   static __init int init_tdx_module(void)
> > >   {
> > >   	int ret;
> > > @@ -1229,6 +1253,10 @@ static __init int init_tdx_module(void)
> > >   	if (ret)
> > >   		goto err_reset_pamts;
> > >   
> > > +	ret = init_tdx_module_extensions();
> > > +	if (ret)
> > > +		goto err_reset_pamts;
> > > +
> > 
> > Hm. Don't we need TDH.SYS.SHUTDOWN/DISABLE on error?
> > 
> > Once TDMRs are initialized the module is functional. Yanking PAMT from
> > under it is not safe AFAICS.
> 
> If we reset all the memory, how is it different than bailing halfway when
> initializing the TDMRs? Some special state changes after the last TDMR is
> inited?

Hm. Yeah, it is not special. The module gets SYS_READY after
TDH.SYS.KEY.CONFIG on all CPU. So it is a new problem.

And I think it is not a problem if we never ask TDX module to manipulate
the memory.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
