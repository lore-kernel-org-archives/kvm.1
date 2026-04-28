Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B42F3C18
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383334; cv=none; b=UHXqUq4LNYMVTrjwaQ+n1Xk+2MTu2iCIrMKaqXZ/g5X0I1y5/jP2MXMi1Ma3m+WZldLR5mJQZLKKIAxzg75VgRanG+01SoE8F29Gm4NuSJgz58hh5vz59Oq3HkAj9Uyf13oKM/mxrd/BphtCUsblQdECuYgdLhxdH6l26+yCw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383334; c=relaxed/simple;
	bh=mcZ3qTphhEWQiMES9jMfFIuxXxXqJ5Xb5H6DddDUwAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f26kbXZd1TTdAFH6mPaqKTsl1FZBRkWA2QI1F/O+usbrKyfkGE18eg8Kkt7wtMcpq1TQjJmDHpCN4acXSACBFjrkDodXfz5MymqStT+uHd77gmKflHM2/XGlTY3Km038kp43qWjjk+/GJu9siEJYXSKRn/xSDrkkv/dj5QUwHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtyOJ6X+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtyOJ6X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777383332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cIzclsS+72CZyW/QMlWEKqRLHUnzm/MuFDenX5zgqW4=;
	b=OtyOJ6X+AiOJr6jWN7IYedAE0cyFRJ8xl84eZ99C1OggFdJFWluGGG0g40vIr+HeftX4FM
	MyU1EgbiiLIexKWIJFFYP1Y27Ml2dpyTG8G6fA92VjxfjUBSRNKVQBl+bWE8/hjIqMi9vh
	z1LECf4qrQU+i515ssrZOTMmOlicd50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-YICE9MysM4-NyDTHzpExoQ-1; Tue,
 28 Apr 2026 09:35:30 -0400
X-MC-Unique: YICE9MysM4-NyDTHzpExoQ-1
X-Mimecast-MFC-AGG-ID: YICE9MysM4-NyDTHzpExoQ_1777383329
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5069F1800846
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:35:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C3F019560AB;
	Tue, 28 Apr 2026 13:35:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Subject: [kvm-unit-tests PATCH 0/2] x86/apic: fix false test_apic_change_mode failures on stalled vCPUs
Date: Tue, 28 Apr 2026 15:35:22 +0200
Message-ID: <20260428133524.3628482-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

test_apic_change_mode sporadically fails in CI on both Intel and AMD
hosts with errors like:
  "FAIL: TMCCT should have a non-zero value"
  "FAIL: TMCCT should be reset to the initial-count"
  "FAIL: TMCCT should not be reset to TMICT value"

The root cause is that the APIC timer runs at wall clock time under KVM.
With the default tmict=0x999999 (~10ms period at 1ns bus cycle).

A vCPU stall for sufficiently large portion of TMICT leads to false positives
(reasons could be: host preemption, cross-socket migration, heavy CPU
contention). It's basically not possible to reliably sample timer values
while it's running.

This series adds retry logic with increasing timer periods (10ms, 60ms,
700ms) so that transient vCPU stalls don't cause false failures, while
real bugs still get caught. (most of false failures are handled by 60ms
timer, and 700ms is one pathological case observed in a week of testing)

Reproducer (requires 2+ NUMA nodes):

  stress-ng --cpu 128 --timer 32 --hrtimers 32 --quiet &
  sleep 2
  while true; do
      /usr/libexec/qemu-kvm --no-reboot -nodefaults \
          -global kvm-pit.lost_tick_policy=discard \
          -device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4 \
          -display none -serial stdio -device pci-testdev \
          -machine q35 -kernel x86/apic.flat \
          -smp 1 -cpu qemu64,+x2apic,+tsc-deadline \
          >> apic_race.log 2>&1 &
      QEMU_PID=$!
      while kill -0 $QEMU_PID 2>/dev/null; do
          taskset -p -c 0 $QEMU_PID 2>/dev/null
          sleep 0.001
          taskset -p -c 1 $QEMU_PID 2>/dev/null
          sleep 0.001
      done
      wait $QEMU_PID 2>/dev/null
  done

patches reduce ~4% failure rate (8 FAILs / 216 PASSes in 2 minutes).
to 0 FAILs over thousands of runs.

Igor Mammedov (2):
  x86/apic: separate reporting from actual measurements
  x86/apic: add retry logic to test_apic_change_mode

 x86/apic.c | 119 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 47 deletions(-)

-- 
2.47.3

