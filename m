Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE513EA94A
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918425; cv=none; b=TEA8IJ8evasC5k+5j+m7qBEg1rwLpzaf7bug5Qbex7BYwI3kSozi1LhYiiGK5W2RhemKJCq4I1yz/mTzwdFx7glhgWidVeVBooMOt9tJ0mQKNE/Fia4Jv4/1uoWgPlkCabx3ayUYA0/jXVmLKhZ2ZAcnGywayXt8pQMfDbykZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918425; c=relaxed/simple;
	bh=r2iJ28zYk63X6K0TBeBbii5OI3M1jSQLNrYEf9Y8Fww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgnwxNI9expLa5SwKWfy7ZovFsS/BErb4BjgL+WMCjX4NMeQ+jsmlff0oMDERBvEuFmdpx2WDc+85+JOIh73uK2ZAcN9poAP2Hphc5rW3NkiTJ2jmdCP+o4IVKPZL1iGQIxCoIs1v28bKKKBiXAmjYwbTo+YtJYZ/I5DNztYWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Csq9yjsi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Csq9yjsi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so8271a12.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785918422; x=1786523222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=egT60UKSOw/b/gAZU/oi1OqDuFs+D8oVvC9scYdRjL8=;
        b=Csq9yjsirNpNZ0Mg4Tx3by7DEqPibtNFiI080WUDHj+OG4aRt/dPlp79lTUZRJRKYV
         m4QhLm0Li9m8d4NT5mMGfpb7QDEqrVqvTjS/mSpfRwAUmPzJz8hP1UfrPu277YqTo0hA
         5cNEjKQ2FfcPGnXRDOSoF6Ik6jVw5XW+9Wy6E7hPA2R7sXTw4TTwiSMVEA6XIO1OfLFp
         fAlg8t/Jmv6jXhs5kbsVhVYYuNVdS2I6f6mOCVnba7vXgLljPER+lfGXcqvujFxLRD0X
         8DbQAAt5Unmn3F0YLEycsp6ht68HvONQhg8LGhSuF1HyYz/YUKAZrxU2EWHLYhwKbEXG
         DZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918422; x=1786523222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=egT60UKSOw/b/gAZU/oi1OqDuFs+D8oVvC9scYdRjL8=;
        b=m8utDttSCn+yUFciCVa9+L8eslvWRUSU60EjabH5LmIwEWJU0R2wDRRG69gIiE1a50
         uRBykgSYq4lK4uX1Wdwet/GsrDYZo9kSl6EZyiKFy4bXArR6fzPUXbB3z+DA8z3gC6Pr
         UyG1lvapd9f+c4+xGu9pse9rdUIKYnKbH+9mynzUHxWW/Svjy6NlkCdvTDrWSC5BqL1C
         IExiUd0dcQrLKuWKEjqOxtxScHhXECCKrUqV9NY+t69EofISMQzQZnNrlmfZoquudaMn
         s1j4asywMg2bWwZ/tLL0l9Vf5Nq733pZQuTWHyrPUflTrFdiiGz8nYCvrB7k7C1wOyMH
         N3cg==
X-Gm-Message-State: AOJu0YxRf9ikbY3sdKVRgbqBSWubbkMqI4D+RcLBhdosq/DAyd4oHF2Y
	oz75dGgl4zQTe/tn6yB4+8n2G7QNvJZv/7IAeICxDEvv+S78DeFADQoXDZ9CMgIOzA==
X-Gm-Gg: AR+sD11CzxTcH3snzhZJrzptkEGRnRbwbFu4fI+IimKGNvmWxhuTiCIQEwuEwCSwPMG
	U03zSz5ZGaxMAwAdIxFhS187TpC3QdG0aVNNgQszWr+ZcH0Jov07CTg1r4l3H9sH3DU4xF40EuE
	MloC7hGWEFUPGaN90SA5qG37Uptyb35THuSJphi1CxRfs4e3W8dvlbaLz5vjCX8JQfogSHfW7Di
	jo/exwLV1AvOLZMThBSogGRmQ8SfksQnkNsBr17gwZB2N4T7Cptujgx6zU7iwwjjqaJKY04VJid
	brBE8qnTAOOz+za4tRx0G+xYKq6okklursa85qBpWM7EGC3VXPlfLVMv0DkKctAy2ex1C71QxcV
	Hxwi6btnlYapwJ09RdcbN7opwJE4RJVWBWUg7vBg021BG25BhRDQ78eesNVX/rCf7dqvlJP5xAJ
	unHwU778NKZnV4IrTbRKjXuKs2hDwFa6fHdN7Vo+zFNiqgLdHXMJ6EIoDqZIrQN0TlPfAqic7Ch
	URQsxeKhP+XfaUFtkCrYkyQ+c5QyeS30RpDJLoZBw==
X-Received: by 2002:aa7:df13:0:b0:698:ac70:31b9 with SMTP id 4fb4d7f45d1cf-6a16c4ee884mr28633a12.5.1785918421404;
        Wed, 05 Aug 2026 01:27:01 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a17bf29168sm571383a12.23.2026.08.05.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:27:00 -0700 (PDT)
Date: Wed, 5 Aug 2026 08:26:56 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jing Zhang <jingzhangos@google.com>
Cc: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [RFC] KVM: Proposed uAPI for querying GSI and irqbypass status
Message-ID: <anLz0HJ9CKuRbTPh@google.com>
References: <20260717162658.2833515-1-jingzhangos@google.com>
 <amh6OLH38hsO7ZWj@google.com>
 <CAAdAUtjrnNe1Kn2_Fqtjy6igEEca-6Zd=SSbncswZtnA5FngPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAdAUtjrnNe1Kn2_Fqtjy6igEEca-6Zd=SSbncswZtnA5FngPA@mail.gmail.com>

Hi Jing,

On Fri, Jul 31, 2026 at 10:26:26AM -0700, Jing Zhang wrote:
> On Tue, Jul 28, 2026 at 2:45 AM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > Hi Jing,
> >
> > On Fri, Jul 17, 2026 at 09:26:57AM -0700, Jing Zhang wrote:
> > > This RFC proposes a new KVM uAPI to allow a VMM to programmatically
> > > query the status of a GSI, with a particular focus on determining
> > > the success or failure of Irqbypass.
> > >
> > >
> > > 1. Motivation
> > >
> > > The primary motivation for this uAPI is to bridge the operational gap

[...]

> > > /* The irqbypass path is fully enabled and active in hardware */
> > > #define KVM_GSI_STATE_FLAG_BYPASS_ACTIVE   (1 << 2)
> > >
> > > /* Example architecture-specific failure reasons for ARM64 */
> > > #define KVM_ARM_GSI_FAILURE_REASON_NONE             0
> > > #define KVM_ARM_GSI_FAILURE_REASON_NO_ITS           1 /* No ITS/GICv4 support */
> > > #define KVM_ARM_GSI_FAILURE_REASON_NO_MSI_ADDR      2 /* MSI address unset */
> > > #define KVM_ARM_GSI_FAILURE_REASON_GIC_HW_REJECT    3 /* GIC rejected map */
> > > #define KVM_ARM_GSI_FAILURE_REASON_INVALID_STATE    4 /* Guest state block */
> > >
> > > struct kvm_gsi_state {
> > >     __u32 gsi;              /* IN: The GSI to query */
> > >     __u32 flags;            /* OUT: High-level status flags */
> > >     __u64 counter_success;  /* OUT: Generic counter for successful bypass */
> >
> > I do not think that is possible on arm64, the host does not know
> > about the interrupts directly injected to the guest, so it can not
> > maitain such a counter.
> >
> > Thanks,
> > Mostafa
> >
> 
> Hi Mostafa,
> 
> Thank you for taking the time to review this RFC and for your valuable feedback.
> 
> To clarify the primary motivation here: the goal of this new uAPI is
> to enable programmatic, stable, and fine-grained monitoring of
> interrupt bypass status in production environments, where existing
> mechanisms like debugfs are simply not viable.
> 
> Here are a few key reasons why we believe a dedicated uAPI/ioctl is
> necessary rather than relying on debugfs:
> 1. Production Hardening and Access Restrictions: In many hardened
> production or cloud environments, debugfs is completely disabled
> (CONFIG_DEBUG_FS=n), unmounted, or heavily restricted due to security
> and performance overhead concerns. Relying on it means the Virtual
> Machine Monitor (VMM) loses all visibility into interrupt performance
> regressions in the very environment where monitoring matters most.
> 2. Lack of ABI Stability: As you know, debugfs makes no ABI stability
> guarantees. Its output format can change between kernel versions
> without notice. Basing production monitoring and telemetry pipelines
> on scraping debugfs is fragile and prone to breaking during kernel
> upgrades.
> 3. Programmatic Efficiency: Scraping and parsing text files from
> userspace is inefficient for high-frequency or fleet-wide monitoring.
> A binary ioctl interface (KVM_GET_GSI_STATE) provides a lightweight,
> deterministic, and highly scalable way for the VMM to query state on
> demand.
> 4. Marrying Topology with Live State: KVM holds the runtime status of
> the bypass, but only userspace (the VMM) understands the full topology
> (i.e., which GSI belongs to which passthrough device). This uAPI
> allows the VMM to programmatically marry its topological knowledge
> with KVM's live execution state without relying on side-band manual
> debugging tools.
> 
> While interfaces in debugfs are fantastic for manual, retroactive
> debugging on a developer workstation, they are not Dependable for
> fleet-wide observability. This RFC aims to provide a proactive
> monitoring solution that aligns KVM with production operational
> requirements across architectures (both ARM and x86).
> 
> Would love to hear your thoughts on this perspective.

I agree that debugfs is not suitable for that purpose.

My main concerns are:
1- Why is /proc/interrupts not enough, it should show whether the
interrupts are going through the host (not bypassed) and it should
show when the host get a doorbell if the vCPU was not resident.

2- Technical feasibility on arm64. Since the host does not have
visibility into interrupts directly injected into the guest, it
cannot accurately maintain the proposed counters vgic_its_vlpis_hw.

Thanks,
Mostafa

> 
> Thanks,
> Jing
