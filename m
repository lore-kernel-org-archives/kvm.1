Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC61E5724
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686557; cv=none; b=JitVFes12G5KzSOHtnVkJceNHXJhcaErz8SKGjmrzSZPQoDin36c4RCyslXhVgsOmXPoPf1GFg3q5mT+ZpUl19GrFzKmNbJ2Q0WAA6Nzc9PsYl7yRlmfn6Im+SxzbFmRBUb0tAuR2Psl0P4K3/ngXsE3vVE6uQTsIZGYV4VlI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686557; c=relaxed/simple;
	bh=fsJIsiGsfYY99SXeg/5j/jowwzLNo0xUxRezocA/mAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGykvBLZGl6DL+zFYz2ICALuWwojZRgCxtL1KIA9U2ks16tv4TNm8BtvXhrGUGtF38spIiFE9oqUW6zUAGBUXBWbaEynhVmzBI47OzKu++/5KaZwXocE4rGRBf0/yqT6+a/syZaf0tBYoKT2tkwTpozyb1eXJn2JsN8CMT7k56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AhUmhVwG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AhUmhVwG"
Received: from example.com (unknown [167.220.208.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id B660020B7128;
	Mon, 20 Apr 2026 05:02:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B660020B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776686556;
	bh=A0yu6PSKAtx4nEVROn2nI1PS6/gjdxCugWFMQbJZxoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhUmhVwGTA5crU+qSH8lPZUj9A/Cm14eNVtKL60/h0EYZi285MQHnh4DmtPFDocZp
	 s3kqq8CYtJz8wEFJWMFwWAVWHJtghc+4xI95VlCysYUetMIk562mfjcRc/5AdHfJ7N
	 wQEbrjhOjHx1uPVDgfKzqXQjOdntayblQec+xmEM=
Date: Mon, 20 Apr 2026 14:02:31 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 30/34] target/i386: add de/compaction to xsave_helper
Message-ID: <aeYV158wcT7A7X3O@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-31-magnuskulke@linux.microsoft.com>
 <83C168E7-02D5-4CD9-9A27-545A88942171@unpredictable.fr>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83C168E7-02D5-4CD9-9A27-545A88942171@unpredictable.fr>

On Sat, Apr 18, 2026 at 07:46:25PM +0200, Mohamed Mediouni wrote:
> 
> 
> > On 17. Apr 2026, at 12:56, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> This patch has a tiny problem.
> 
> #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> void *xsave_buf;
> uint32_t xsave_buf_len;
> #endif
> 
> With the "#if defined(CONFIG_KVM) || defined(CONFIG_HVF)” removed,
> that fixes a TCG only QEMU build.
> 
> Was also able to test that this works as expected on WHPX.

thx, that's right. we can also change the signature to pass xsave_buf
and xsave_buf_len as params, so accelerators which do not have xsave
buffers do not choke on this, it's probably less invasive rather than
including xsave_buf fields for all accelerators.
