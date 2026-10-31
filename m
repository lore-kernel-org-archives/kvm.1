Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436004;
	b=LSYWtdyE1zDOtYifLR0/yg200zJU5QghBoLXzUSeWDtpzYIdYMRsjJL+wwq0sTiBXrnP
	 s8hIXufgmqgyRg+k2U6L7X5xSrJacDW4SMCJvbdjB0rLvZv9jzTQakzA8R3HtIQ4aMGj7
	 D4ocMud6YOXNmXayLGGQkzGcuXGWIakHWGWFqtmCEDoTh3LsSnw34Vz4aL/rnMPKPsfFy
	 xr4NUY1scw1fQr/oPuCzBboePUfena2yrXXv+scb/BPicmebwfHbKr5K4nQWj2ppJa2IB
	 /CGcTDY9EWb45tc2CLPJJgMZDJG/rXnv1TyUkN6XdcQRCRR96XnJ2fQQuU99HNhTexw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436004;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=U6dIqI1m3iSWXQcZuC6+/1Cqc1LHwr0ImOGfQ6XK9co=;
	b=g72Obx0DohCEUcUDdM21TeDoC4+d8P4/+RE42z2bzWQ5/Thh2AivcU21zeTYhkkG+NcL
	 PJbCj/owJzBU67UfzXSl4Mg5qFaFd5DVUf0oSSE4yhrperVMlvaTMqHl5Mk2JIaBGfh6M
	 jj/mmSpDLVb8jLTiwEXfDN+YhPbv6RPeIjg66HJ1aqr7j1pxMs5ArufvUMKBNW2alLvXX
	 ItcwdaeZOrP0NMjEAzzXaj5xLuJgzqjd1cP622kR6pHKZ0kNo6zVXCEJqzDPf8gyVrOfn
	 o6Q0NMuaGec2QfFaYuxOlPSntJvWmwPykWvgdyvBAzHbTpepzpesrDJJLUb3VNnU+xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZrQUVmV0;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF245606A31C;
	Sat, 31 Oct 2026 08:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF245606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZrQUVmV0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U6dIqI1m3iSWXQcZuC6+/1Cqc1LHwr0ImOGfQ6XK9co=; b=ZrQUVmV0H9f/oXSHSzP6b8SYg2
	hIpc/1endH/Fi0znR62eXqzVPuYsRKBey3DpvpeS97GCohS5qWScXewmzCQRJcDe/fnLVta39TMEA
	bJ2ANOBPwSzlIzmT8UoWQ10ovxNnYiRwQyiwq9l3FOAq7/UW8bWKgUw/w6wroLul6bln/F71cQ0nS
	5NV0+TV+942f/Ua6m24ylmrEZSitYCKGCiXP+4OGdbQgTpzT5u/81OLDQ8Cqbm+DKFGAoTNfwybXV
	Pu84KhYqoAg0rIyAoeKdyOANDZFQHAXLgsYFEShL3R9Xmt/qviMJ3cv/f8TfiCYT14FkRByLUnWtf
	O5A/UKbA==;
Received: from mailer.gwdg.de ([134.76.10.26]:60238)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN4d1-001WSU-10;
	Sat, 31 Oct 2026 09:39:54 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN4d0-000C1b-2t;
	Sat, 31 Oct 2026 09:39:54 +0100
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 31 Oct
 2026 09:39:53 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>, <amirmohammadeftekhar@gmail.com>
Subject: [BUG] KVM: nVMX: guest-reachable KVM_BUG "Guest always owns CR0.TS" via stale vmcs02 CR0 read shadow
Date: Sat, 31 Oct 2026 09:39:43 +0100
Message-ID: <20261031083943.64279-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-fmz-02.um.gwdg.de (10.108.142.53) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

Reporting a guest-reachable KVM_BUG() in the nested-VMX CR0 handling. On a
default host it is a WARN plus a forced self-kill of the VM (-EIO on every
vCPU); on a panic_on_warn=1 host it takes the host down. It is not a
memory-safety bug. It still reproduces on top of the in-flight "KVM: nVMX:
Honor L1-owned CR0 bits for LMSW" v3 series
(<20261030213747.2611815-1-seanjc@google.com>): that series fixes the LMSW
arm, but not the two paths below.

The assertion
-------------
handle_cr() treats a CLTS CR-access VM-exit from the guest as impossible:

	case 2: /* clts */
		KVM_BUG(1, vcpu->kvm, "Guest always owns CR0.TS");	/* vmx.c:5725 */
		return -EIO;

That holds only while the vmcs02 CR0 read shadow stays equal to
nested_read_cr0(vmcs12). prepare_vmcs02() establishes it:

	vmx_set_cr0(vcpu, vmcs12->guest_cr0);
	vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));	/* nested.c:2842-2843 */

and handle_set_cr0() re-establishes it on the MOV-to-CR0 exit path
(vmx.c:5623-5643). When L1 owns CR0.TS (cr0_guest_host_mask.TS=1), prepare_vmcs02()
also sets CR0.TS in the vmcs02 guest/host mask (nested.c:2808-2809), so a CLTS
by L2 *can* raise a CR-access VM-exit, and KVM relies on
nested_vmx_exit_handled_cr() (which reads vmcs12) to reflect it to L1 before
handle_cr() ever runs.

The break
---------
Three L0-side writers run while is_guest_mode() and overwrite CR0_READ_SHADOW
with the raw CR0, bypassing the nested merge. The write is unconditional:

	vmcs_writel(CR0_READ_SHADOW, cr0);			/* vmx_set_cr0, vmx.c:3466 */

- M1: a runtime KVM_SET_SREGS2 -> __set_sregs_common() -> vmx_set_cr0(). This is
  reachable from the guest through QEMU's vmport: an IN/OUT to port 0x5658 from
  L2 makes QEMU issue a runtime KVM_SET_SREGS2 of the current register set, which
  round-trips the real CR0 (TS=1) into the read shadow. It needs L1 to expose
  0x5658 to L2 (vmport is default-on in QEMU).
- M2: RSM back into L2. leave_smm() re-enters L2 before rsm_load_state_64() ->
  rsm_enter_protected_mode() -> kvm_set_cr0() loads the SMRAM CR0 into the live
  L2 (ordering from 72e9cbdb4338, "fix SMI injection in guest mode"). This needs
  only an SMI taken while L2 runs (SMI IPI from a sibling vCPU, or a firmware
  SMI); no vmport and no SMRAM edit are required.
- M3 (L0-handled LMSW) is the arm your v3 series fixes; excluded here.

With L1 owning TS (cr0_guest_host_mask.TS=1, cr0_read_shadow.TS=0,
guest_cr0.TS=1), a clean entry leaves vmcs02 CR0_READ_SHADOW.TS=0
(nested_read_cr0), so CLTS does not exit (verified control). After M1 or M2,
vmcs02 CR0_READ_SHADOW.TS=1 while the mask still owns TS, so hardware raises the
CLTS CR-access VM-exit. nested_vmx_exit_handled_cr() case 2 (nested.c:6386)
consults vmcs12 (cr0_guest_host_mask.TS=1 && cr0_read_shadow.TS=0 -> false), does
not reflect, and L0 runs handle_cr() case 2 and hits the KVM_BUG. KVM_BUG() then
WARNs and calls kvm_vm_bugged(), so the VM is marked dead and every vCPU returns
-EIO.

Confirmed
---------
Mainline (7.3.0-rc3, KASAN) and the kvmCTF 6.1.74 build, as throwaway nested L1s.
arm 33 = raise an SMI while L2 runs, RSM, then CLTS; arm 32 = IN 0x5658 then CLTS.
Both -> KVM_RUN -EIO with:

  Guest always owns CR0.TS
  WARNING: arch/x86/kvm/vmx/vmx.c:5725 at handle_cr+0x32e/0x1df0 [kvm_intel], CPU#1: t3vmm/132
  Call Trace:
   vmx_handle_exit+0x3e1/0x15a0 [kvm_intel]
   vcpu_enter_guest.constprop.0+0x2110/0x3960 [kvm]
   kvm_arch_vcpu_ioctl_run+0xd92/0x27b0 [kvm]
   kvm_vcpu_ioctl+0x66c/0x1480 [kvm]

The control arm (CLTS with no preceding clobber) completes in L2 with no exit, as
expected. I also applied your v3 LMSW series and rebuilt the host: arm 33 still
fires (now at vmx.c:5726), confirming the series does not cover M1/M2.

Lower-severity side effects of the same clobber (L2->L1 fidelity, not the
KVM_BUG): until L2's next nested entry, an L2 MOV-CR whose L1-masked bits match
the real value no longer exits to L1 (lost CR intercept), and L2 can read
L1-hidden bits (CR0.TS, CR4.VMXE) from the clobbered read shadow.

Fixes / suggested direction
---------------------------
The desync dates to the original CR-shadow handling (eeadf9e7558c); the RSM arm
to 72e9cbdb4338; 673692735fdc turned the resulting CLTS case into a VM-fatal
KVM_BUG. The fix I would suggest is to keep the nested read shadow consistent on
the L0-side writers while is_guest_mode(): write nested_read_crX(get_vmcs12(vcpu))
to the read shadow in vmx_set_cr0/4() (or recompute the shadows after
rsm_load_state_*()), the same merge handle_set_cr0/4() already does. This is
adjacent to your v3 CR0 series, so it may be cleanest to fold it in there. I am
happy to send and test a patch if you would like it done that way.

Reproducer: a standalone C VMM (arms 32/33, an SMM handler that just RSMs) plus a
KVM-unit-tests variant that reproduces the read-shadow clobber under real QEMU
10.1.0-rc3 and 6.2.0. Happy to share either.

Thanks,
Amirmohammad
