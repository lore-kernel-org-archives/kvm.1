Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B23D6487
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396922; cv=none; b=D6jIE6ze0TuFe8CkrFyCZGpT6ztZPvsmE4mtB3PMphBkP5PGd5UsUpwzgxqNeTnfM1FYH0NreUbfnVjOx5WcrSVEUBjJ+duAZ1PoKezdgpjNkczguJg9rENxVQlanWvjBn5AOr8IDCPmXvKUej9r1LAeQAiIS+PEkRxgzbvhDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396922; c=relaxed/simple;
	bh=jM7oNFuzQLQ8lpmpgK8Tn+3BSv3pHDrlze6z7UXaNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j2ZO7lM5tazu9Zh87NYRZpA2HKzWBBffwLMLyupC62OPdvJqTcFjS7YLSDL0aEzPGOKgnBxeomOqbb0TmG+wtF15VfUePfvqLm50/kXzuU3NJwpzAdC1FlPDD0bAGu5rl4kWHZPSfKIXEAZlmrDor8CIHgd8Rx82Z1yW8vpsF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5008f45b55d4dd6762d.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:8f45:b55d:4dd6:762d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 26E2A1C6983;
	Tue,  2 Jun 2026 12:41:59 +0200 (CEST)
Date: Tue, 2 Jun 2026 12:41:57 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: coconut-svsm@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: [RFT] KVM Planes on Linux 7.1 ready for testing
Message-ID: <ah6w0xGq1jtKNJen@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

An updated version of the KVM Planes patches is now ready for wider testing.
The branches are based on Linux v7.1-rc6 and QEMU 11.0.0. Before sending them
out I'd love to get more people from the COCONUT community test the changes and
report any problems or regressions agains the 6.11 version.

The Linux branch is here:

	https://github.com/joergroedel/linux/tree/kvm-planes-v7.1

The QEMU branch is here:

	https://github.com/joergroedel/qemu/tree/qemu-planes-linux-v7.1

Both need to be used together, the current QEMU svsm-igvm branch will not work
the kernel above.

For QEMU, there are some minor changes needed for the command line:

	- Add a device-plane=2 parameter to the machine specification

	- Use irq-chip=split

As an example, my QEMU command line starts like this:

         qemu-system-x86_64 \
             -enable-kvm \
             -cpu EPYC-v4 \
             -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
             -object memory-backend-memfd,id=ram1,size=32G,share=true \
             -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
             -object igvm-cfg,id=igvm0,file=$IGVM_FILE \
              ...

If no major issues are reported, I plan to post these patches to the mailing
lists for KVM and QEMU by next week.

I plan to update the COCONUT-SVSM downstream branches for KVM and QEMU once
Linux 7.1 is released and regularily rebase the changes to newer kernel and
QEMU versions, also incoperating review feedback from upstream.

Known limitation: The direct-VMSA setting support we have in the 6.11 kernel is
not part of the KVM planes patches yet. I plan to send a separate patch-set for
this feature.

Happy testing!


-Joerg
