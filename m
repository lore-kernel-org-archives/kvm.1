Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74993D1711
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862645; cv=none; b=IFzL4XWyN3Jjmwva6EzyW1p4lQqXBQi0S5t//ukTQeJgcSgkIBQ1EBQaNK3MNh0mtQKafOTKb1G1c5gBqcczbaOqjNOxOwcRMJvZboFxsn+Ia8geF25LAalXRKDeTnNdIat1vqcRZ2PLYWElnbH8INsreS/tqb1nSWYzJdCQdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862645; c=relaxed/simple;
	bh=i+UbOwWqMgpssWJ3B+3lbxW8w6OY5CYF4YTaS6tILGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYhWIHwgVU0Kp4BTvINjpxxAQrmEgiY9qAztidIKRZ9NhHv4xIldDM2Ihb+tEe3xzdUlzdwn4JSv0mZxMZ6c9l+06arjZDyvPn0b+0NjQ4Naq5qTzv2c08UZHyAuXLw8+C6fz5t8UBRZsjGFBBibDGspihiL85jYQQXEnF0M4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k/dpX5CM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k/dpX5CM"
Received: from example.com (unknown [167.220.208.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 886F120B6F01;
	Wed, 22 Apr 2026 05:57:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 886F120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776862644;
	bh=GkyMoNv3DEhmejdoMuZt1WIwI2IrPe33BUhDY+BehLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/dpX5CMDWD/DiecWpZRHxHYpzwW8L5hTI+6U5P7OhCcmd0CH2mk2Ienz5ZdnM9zO
	 rBMFZz+X+ItVlwN/57xpLFxMl28ZBD67VomNpq0pbZof61WOw0HOWMNHIxedXNO6/S
	 JMs6OiQjZlLiwINLwL4cJxu9Yf/QBN5R/0vyvtFE=
Date: Wed, 22 Apr 2026 14:57:18 +0200
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
Message-ID: <aejFrlqsVuchoSkK@example.com>
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

as we discussed offline: there is mapping code in the mshv-ioctls
crate and some prior art in WHPX that we can use as a reference. So
we are to able to roundtrip the lapic state using generic field on
APICCommonState and a few additional mshv-specific fields. This seems
to work reliably in my migration tests.

I'll update this in the next iteration of this series. A KVM <=> MSHV
migration path remains a non-goal, but it'll be a bit nicer to have the
state transparent in the migration stream.

best,

magnus
