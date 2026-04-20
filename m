Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0652BB13
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685049; cv=none; b=tlxomOXuPLGKgxQt1qpbv+IL/ja+SgOfVc4Q8uWLujxWC/FMa9WYjX/IkIVQ5cxEGb7U8ivqHHJHAtaX963lCY6wrtsOMWz1yiKutNorXOVHEGKd97tHSZrgRn8mCVvundw1EbKnD4LXA3vzFkO3IWRKJ1fCpCgBk9ZAfwaqlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685049; c=relaxed/simple;
	bh=w96xsXBqXACbEYuGLknjUx74w8KbcBEuKYcCaA6XSLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGE5GoVpvp8xe3TA0xIXQf31sIXnzOiA9J9KNBjNjp7nX2q7VfoVyzx/KOi9ueb7zbDHW9Wkj3IEqAbHahhszPBHSVz954Bxxi4hupk8c/AB2hRmUQbpBJh9dzWvbly0JqdPncRhry0nObP4p5PEb5L3fYxge/uMcoIUkx4nNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RDGaNCFN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RDGaNCFN"
Received: from example.com (unknown [167.220.208.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14E8920B7128;
	Mon, 20 Apr 2026 04:37:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14E8920B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776685037;
	bh=hMztnChoRWBhJVAeBAm1kILl7UPyeglHbYha958D4VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDGaNCFNst+wbGoqTqVFYjzbeGbMSVZXWxThgokV0kE43dlDhDeGxIu0ZrhGtjD5n
	 kXzw6SnXNzM9rwG2Tz2+R8PbrI8fh+2RS9ogBXEZ5STWwN4H430ykMuaehXHG/wNPM
	 41fsjT4o4NeY0aunVC5xso4ApPs5MD8vR5SUzMts=
Date: Mon, 20 Apr 2026 13:37:11 +0200
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
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Message-ID: <aeYP5204OgzMUVRO@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>

On Fri, Apr 17, 2026 at 01:54:48PM +0200, Mohamed Mediouni wrote:
> 
> 
> > On 17. Apr 2026, at 12:56, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> > 
> > This change implements loading and storing the hyperv lapic state as
> > part of the load/store routines for a vcpu.
> > 
> > The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
> > only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
> > userland.
> > 
> > An opaque blob is added to the APICCommonState, guarded behind a flag,
> > hence it will be covered by a migration, as we declare VMSTATE_BUFFER
> > for the hv_lapic_state field.
> > 
> > In the future we might want to introduce a dedicated class for MSHV, that
> > would require us to wire up an IOAPIC delivery path to QEMU's userland
> > emulation.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> Hi,
> 
> Is there a way to make this not opaque in a way that retains the ability to
> Save-restore between KVM and MSHV? 
> 
> Or is that not a wanted goal?
> 

yeah, for the time being it's a non-goal. there might a way to map
hyperv lapic state onto existing state fields, but the mshv crates
(which is the closest to a reference impl for mshv uapi) currently
only expose the state as an opaque buffer.
