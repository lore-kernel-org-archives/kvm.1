Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8223DDDDE
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889106; cv=none; b=LWhF4aGSrTKLos8lxfwQIcb7Sfnm7rdp6YgF7w0vdenh6rFSeOw2ipl7x2WFmmOXpitkIkXo3i1K1zxs56xUH4BVJS4l1SBKL7XH/4v/IbkBFY4tWdg3VcH1AW9uLVO2TSudKDlj5P5k6vplmhhTZlgRsTQXE+YF4FaKKrjfnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889106; c=relaxed/simple;
	bh=jhMAMe5deumSATt2YZjZO9CnIAV20Mdp5mKgVCJ6KiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohwm9HO3LSt7RBeo2mba1vjFT3ejzh7ehWGo+mCs18nq9juKrtSOwdNCfNbaiy8CLJE/GOX6x0AFkQrh7QTpTshn0Hsc1UKGm2u3TDsaTCBG+Eq3j4wD6PjUP4Y50Xqfi4Kt9YmSz0PoyPEBisfGYFMdEpYMYqr4tpRoIlcDiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXGhYLDN; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXGhYLDN"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so27584675e9.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889103; x=1790493903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7VibR2ejrZmc9O6OW8RI4q4uqsysauF7NG6R5Tz7yU=;
        b=XXGhYLDNbYdr27vF0Lzb1EUSU/2xMbxkUGRE6fD5CLrAaSRdn4pPkOrUSevo8sXo1y
         mjG/xOqfuCbNh2lEZdo1NSEJRa9RkXkiSRxLRp9EEKWgLB7Yjc8tu07nT/creiQ4/E6q
         CAY+wJ+uinkBIDUCnPHPGBJ9AoKKXhDxjoTG+cjpmEBl5+oos87v4wVByM1Wxf+6TL3m
         EpMjy+YaxAcGM450zYNhaFH+fwPnbg6CginsIGWyDY8XvLmTzvea4jkBJbMeB7GOZh6m
         nl60WR1bsTUk6g/QbOg1OqG5wtzfiimshTgPjeP+1+ErWZZJ1NnXZJMNed8nfPEjCZkK
         5kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889103; x=1790493903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7VibR2ejrZmc9O6OW8RI4q4uqsysauF7NG6R5Tz7yU=;
        b=KCxRPPQpIJMnmIWsHEjpCTxxm/Q6Uge7G4wK423d0lUxi0BiYvb184NUzNjO+p52/J
         QF7RZYP48PgBWIo7QI2RHNtwLOfOn5Ex9vTmeyySBMT/0MJrcEVq/BL7xpTK7jjJoF7L
         FKDNmDmZVQM+BB4aiBkSkJ/rtgL9K0MGt0CApBlMBcyaV7fBn2GmopiiBRTOhxydm/tQ
         4qro/vIOMvorYUVQYEn9ld98J7pcbYQaRv8gr0nxUCtpJDW0eY3mfOyMh7mFyDjqW686
         plcgm8o4Y12e2fy2cN+OLQD/j673aR0wx+/K7SyzgKBLdMeS7fJ2fRIIkG+FstpQVC1V
         Q2VQ==
X-Forwarded-Encrypted: i=1; AKwUvByA2d+VnlaBlTYsw4hBqc/CXXFutZp3H8GGkJlPLa97MQod26+c92O6eFwzVPWcNYn5F3c=@vger.kernel.org
X-Gm-Message-State: AFuF++mcGTtFNViNf7W1rgZGlYhYtrIbyQjwoLF1xbVH2+7JGyGV2iqU
	TCkx38wNPZ3uEfL2+n7qCPP/PIOSzbnAcD5OY320a5euphioUQfTeASS
X-Gm-Gg: AYBFou3QIAOvAgVJtCgncVhOsvS3B4wNtriv/7SSrfGIdd7D29mgpCqpWhOfZ1GV2f4
	g8OJoW8sgMeoxieL4wH2+aVUsQUU71SXByMp9uP0bUf9ZGcA3BNqRVAP9xhBbkb1VlH5PtWU7Og
	el3wwdYDqUPoLl31H+u6BxYDtfx8tycm085TPEbWeuEN5UStuPwsG9T6dGR/hDTSs+2IosBemZE
	HSQWwlrijFTsCI/zqAhRsPTIQ31ORSvID0/Wa+mKY1qTkDbsXlmPBieTW408OsNV37rDH3Pg4+5
	6gUauyFqvU85t0Et1gvJBMyed+trIbTIrSKpesnxddCkZ7DNxdmogHqYfsxxlSEbB2EB9N8AHSj
	HBpCvupohyKAcXVoHWvjU52csF59ssmLtRxmrUfs/0VXsn5R04Nb8XgMAncgIenJJ8W5RiXxjpd
	65nahaCSUx3VshP/+3OEiOGwcjWknFYh8U/Qnd618MVBmYSHlLwxtus2yQoAFPi37NrLXIZr56b
	1gSOw==
X-Received: by 2002:a05:600c:6296:b0:49e:6fd2:a45 with SMTP id 5b1f17b1804b1-49fc5737c43mr100407105e9.16.1789889102652;
        Sun, 20 Sep 2026 00:25:02 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm125191575e9.9.2026.09.20.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:25:02 -0700 (PDT)
From: mike.malyshev@gmail.com
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org
Cc: amoorthy@google.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	xiaoyao.li@intel.com,
	yu.c.zhang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH v2 1/2] KVM: x86/mmu: Report a memory fault exit when the fault handler EFAULTs
Date: Sun, 20 Sep 2026 07:24:58 +0000
Message-ID: <20260920072459.3485710-2-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920072459.3485710-1-mike.malyshev@gmail.com>
References: <20260920072459.3485710-1-mike.malyshev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anish Moorthy <amoorthy@google.com>

KVM_CAP_MEMORY_FAULT_INFO documents that KVM_RUN will fill
kvm_run.memory_fault when KVM cannot resolve a guest page fault VM-Exit,
"e.g. if there is a valid memslot but no backing VMA for the
corresponding host virtual address".  kvm_handle_error_pfn() does not
honor that guarantee.  It returns a bare -EFAULT, leaving userspace with
no indication of which guest physical address faulted, or even that the
exit was a memory fault at all.  Userspace cannot distinguish a
transient, resolvable condition from a fatal one, so in practice the VMM
terminates the guest.

Fill kvm_run.memory_fault before returning -EFAULT.

A concrete user is an Intel integrated GPU assigned to a guest via
vfio-pci.  The guest driver clears PCI_COMMAND.MEM on one vCPU while
another vCPU is mid-MMIO to a BAR of the same device.  Clearing
PCI_COMMAND.MEM makes vfio-pci zap the BAR's mmap, so the second vCPU's
fault finds a valid memslot whose VMA can no longer supply a PFN, and
KVM_RUN fails with a bare -EFAULT.  The VM dies, even though the guest
did nothing architecturally invalid and the condition clears as soon as
the driver re-enables memory decoding.

Reproduce by pairing a vCPU that spins on accesses to the assigned
device's BAR0 with a vCPU that toggles PCI_COMMAND.MEM; the race is hit
within minutes.  The same crash has been observed in the field on
production edge hardware.

Reporting the fault does not by itself define the access semantics.
Userspace still has to decide what a read or write to a BAR with memory
decoding disabled returns.  But it is the information userspace needs in
order to make that decision instead of killing the guest.

Suggested-by: Sean Christopherson <seanjc@google.com>
Fixes: 16f95f3b95ca ("KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to userspace")
Link: https://lore.kernel.org/all/20240809205158.1340255-1-amoorthy@google.com/
Link: https://lore.kernel.org/all/Zr-8M9rYplgN6IS3@google.com/
Signed-off-by: Anish Moorthy <amoorthy@google.com>
Co-developed-by: Mikhail Malyshev <mike.malyshev@gmail.com>
Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---
 arch/x86/kvm/mmu/mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9788ff1803740..244575f576071 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3616,6 +3616,7 @@ static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fa
 		return RET_PF_RETRY;
 	}
 
+	kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 	return -EFAULT;
 }
 
-- 
2.43.0

