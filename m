Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10A2DCBE3;
	Thu, 11 Jun 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190656; cv=none; b=QS7NRhOs8emPVWbOy1qEoibZbOaSb70BnR3onmRtbn2cnQI6dIGdrqTVyMgJiiG0rQk0IvSsIj6YPD4uzQCa9Fms3MX/GEpvU0e+HcN8O/1LwQ1BdzOVi96eBn3FDbpCsHZzTIn6gvGMV5YiFDLKBAhDKOx11ytl0JULkGgpF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190656; c=relaxed/simple;
	bh=p6JyQTIpeebGkRpKW3NS1DfqfqoQKzrp/k2iJUqKgWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D6u5ykxM78HpWvtrUeeMOyoY5RfdjAR+W/9OrkhN1kbRN4ZUC9vlWS6HxLM115nkHb6INATTB970voA/JoUW/DVVve/Plm2O6dNEkKQGQ+tw8/dOw8K8pjkXCewSzzBkHiOZjEUQqt5er/u4Hq7XdCs2snekiYeeO4nm0cHmUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S4emYf43; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S4emYf43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Mime-Version:Subject:From:Date:
	Message-Id:To; bh=z6Rs1xQabtiKMN6NBugIIZY259GLb3D35RZ3zZcle9Q=;
	b=S4emYf43ukUq5QBkGnYS7F29yU48VDJ4N8gtpIIE5AbjrKPXSjIhLiridugNLl
	TOhNsu35TwTTHGzSnBzVxjPMQzRLznYITXac+fB53sFgdYFVL8Vw4sYtBZtFieNC
	bJNd1mcSLlI45TG8szziOcVTUyX+ruhvu72dR5SCnNcZQ=
Received: from smtpclient.apple (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBnWQ29zypqq2w5Cw--.18009S3;
	Thu, 11 Jun 2026 23:09:50 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] KVM: SVM: Clear dummy V_IRQ in vmcb01 when deactivating
 AVIC
From: xinguo <m18700951735@163.com>
In-Reply-To: <ain7hUsLC2VSlkP6@google.com>
Date: Thu, 11 Jun 2026 23:09:39 +0800
Cc: pbonzini@redhat.com,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <578D99D7-4B18-44CD-85C5-95A88B0707D0@163.com>
References: <20260610070512.85463-1-m18700951735@163.com>
 <ailce3eU59J4bv6x@google.com> <5230F158-B766-4BDD-8D94-FFE6AA46BF8C@163.com>
 <ain7hUsLC2VSlkP6@google.com>
To: Sean Christopherson <seanjc@google.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-CM-TRANSID:_____wBnWQ29zypqq2w5Cw--.18009S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWkAry5KF4UZryrXFWxCrg_yoW5uryUpF
	9rWF4xtr4ktF1IqF97tw4DZFyrurZ5Wan8GF18JrW7Zw15KF1IgFySyw4F9a9rCrs3W3WI
	vr4UJ3y8ua1Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrwIgUUUUU=
X-CM-SenderInfo: jpryliyqzvilitv6il2tof0z/xtbC6h5Ijmoqz74+wAAA39

For context, the first issue I hit was the one fixed by:

  87d0f901a9bd ("KVM: SVM: Set/clear CR8 write interception when AVIC is =
(de)activated")

After I backported that commit, the original failure no longer
reproduces.  I then started stress testing repeated AVIC
activate/deactivate transitions, and under that stress workload I hit
the new Windows crash that made me look at the dummy V_IRQ path.

So this may be a separate issue in the AVIC inhibit / IRQ-window area,
rather than the original CR8-intercept / TPR problem.  My current tree
has 87d0f901a9bd applied, but does not yet include the four IRQ-window
inhibit commits you pointed out.

I'll backport those commits as well and re-run the same AVIC toggle
stress test.=20

> 2026=E5=B9=B46=E6=9C=8811=E6=97=A5 08:04=EF=BC=8CSean Christopherson =
<seanjc@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jun 11, 2026, xinguo wrote:
>> Fair point, my changelog reasoning is incomplete and I owe you data
>> rather than speculation.
>=20
> Oh, I'm not doubting that there is a bug, I just don't think that =
purging V_IRQ
> when AVIC is disabled is the right fix.
>=20
>> What I actually trigger is a workload that repeatedly toggles AVIC
>> on and off, i.e. avic_activate_vmcb() / avic_deactivate_vmcb() get
>> called many times in quick succession.  Under that load the Windows
>> guest blue screens with STATUS_INTEGER_DIVIDE_BY_ZERO.
>=20
> What kernel version are you using?  And do you happen to know what =
exactly is
> causing AVIC to be (un)inhibited?  I ask because these commits that =
are landing
> in 7.1 might be relevant:
>=20
>  fa78a514d632ed2428b7c573108d9658c00d536e KVM: Isolate =
apicv_update_lock and apicv_nr_irq_window_req in a cacheline
>  5617dddcfa30129562d7028ec766797d8c345f36 KVM: SVM: Optimize IRQ =
window inhibit handling
>  6563ddadd169cc6f509a75b3ff8354309dcb9080 KVM: SVM: Fix IRQ window =
inhibit handling across multiple vCPUs
>  7b402ec851cb66e73ee35913c7d802bba820086b KVM: SVM: Fix clearing IRQ =
window inhibit with nested guests
>=20
>> =46rom the dump, Windows takes the bugcheck while dispatching an
>> interrupt: an unhandled #DE is raised inside the interrupt dispatch
>> path and ultimately reported by nt!KiInterruptHandler.  The faulting
>> RIP saved in the trap frame is:
>>=20
>> 	je   nt!KiInterruptSubDispatchNoLockNoEtw+0xd5
>>=20
>> which is a conditional branch, not a div/idiv.  In other words, the
>> guest is being vectored through IDT entry 0 (#DE) at an instruction
>> boundary that has nothing to do with division, which is consistent
>> with the CPU delivering vector 0 from KVM rather than the guest
>> actually executing a faulting div.  That is what made me suspect a
>> stale dummy V_IRQ (vector=3D0, V_IRQ=3D1) becoming effective once =
AVIC
>> is disabled.
>>=20
>> I agree this needs to be backed by traces, not just by that
>> hypothesis.  Let me instrument svm_set_vintr(), svm_clear_vintr(),
>> the intercept-recalc paths, and avic_deactivate_vmcb() to capture
>> vmcb01's int_ctl / int_vector / INTERCEPT_VINTR / is_guest_mode()
>> at each transition, reproduce the crash, and come back with the
>> actual call sequence that leaves vmcb01 in a state where V_IRQ
>> becomes effective once AVIC is disabled.
>>=20
>> Please hold off on this patch in the meantime; I'll resend (or drop
>> it) based on what the trace shows.

