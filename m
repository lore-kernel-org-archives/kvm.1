Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54D4071E9
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409381; cv=none; b=PG2nVcqXpgvyOXSLWJllqT+6IA7KsTK3bzttEhWQESEwrp9aI+lVMencQB2epsatkFg9phJjXAV1DNgQ8pum8N16U8bVDe5xaeTVvvlov8oFk0YQWJFO9s9W7zfVvC4kWiL2bPb4RV8iVzDenm846R2HWFj6b2ser0bFCh2l6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409381; c=relaxed/simple;
	bh=hFS3hhrEjm7Iilrrdo7J/ms/HMz8aVhin2mHFh7m4yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGr598DgU+aS52HM48lkmqpQaJCJ0vmqHLSNlad6y97VsAUFxttveB6dXhpVd/7TlGlT5UwwpQZNEe1mvzT0SIfGdsOqDF4fR+Dkaf2ts1w1oJhZwJkQcoK0bJrR83ssVMDi/0OXymOHs8H6VYvJsCzqM0DqdTDWPdLQ3J2VJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVVwu0pw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVVwu0pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785409378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2QWVsKwSY5f2aALx7A2Y/kpJV//Dd4ebcO5MiUk08A=;
	b=EVVwu0pwiJA1ex05X9cDyUG38251YnsvOr7gPNaOha0D7QcZwwpsDUJR2Sjz1arQCQ84pT
	OonyhilCoK8pBsb8kDIST2/GMbXApzoZgZ4XJWMr/Y7nL6jf8ewS9wboWxg9/tq4LeN0mY
	0GpbDeQwO9C5OoyF8b6PUkHWVHrYy5c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-C3CcKHE7OBCOh9YgU8eeww-1; Thu,
 30 Jul 2026 07:02:54 -0400
X-MC-Unique: C3CcKHE7OBCOh9YgU8eeww-1
X-Mimecast-MFC-AGG-ID: C3CcKHE7OBCOh9YgU8eeww_1785409373
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACB3419560A3;
	Thu, 30 Jul 2026 11:02:53 +0000 (UTC)
Received: from alougovs-mac.redhat.com (unknown [10.44.33.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFC1219560AB;
	Thu, 30 Jul 2026 11:02:50 +0000 (UTC)
From: Alexander Lougovski <alougovs@redhat.com>
To: tycho@kernel.org
Cc: Alexander Lougovski <alougovs@redhat.com>,
	bp@alien8.de,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	thomas.lendacky@amd.com,
	vkuznets@redhat.com
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
Date: Thu, 30 Jul 2026 13:02:46 +0200
Message-ID: <20260730110248.49444-1-alougovs@redhat.com>
In-Reply-To: <amkdorffsAuguuIk@tycho.pizza>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jul 28, 2026 at 03:34:36PM -0600, Tycho Andersen wrote:
> my LLM complained about the '% 2800000', looks like it's selecting
> from 1..2.8M in a 1.6M table, so the updates above 1.6M don't affect
> any rows.

Hi Tycho,
ah, true. Your LLM is correct. I've been experimenting with the different sizes of DB to ensure more memory churn (avoid sql reading from the cache) but then settled back to 1.6M.


Another thing to mention, it looks like 1582 workload version I've shared doesn't work correctly. So I'm attaching an improved version which mitigates problems - the version I shared before, was still generating a noticeable amount of TLB flushes but still wasn't exactly working as it's supposed to. So here is the improved version:

---------8<-------------


$ErrorActionPreference = 'Stop'
$logFile = "C:\drivers\workload-1582-errors.log"

$block = {
    param($logFile)
    $files = @(
        "$env:SystemRoot\System32\ntdll.dll",
        "$env:SystemRoot\System32\kernel32.dll",
        "$env:SystemRoot\System32\user32.dll",
        "$env:SystemRoot\System32\advapi32.dll",
        "$env:SystemRoot\System32\ole32.dll",
        "$env:SystemRoot\System32\shell32.dll",
        "$env:SystemRoot\System32\comctl32.dll",
        "$env:SystemRoot\System32\msvcrt.dll"
    )
    $i = 0
    while ($true) {
        $f = $files[(Get-Random -Maximum $files.Count)]
        try {
            $fs = [System.IO.FileStream]::new($f,
                [System.IO.FileMode]::Open,
                [System.IO.FileAccess]::Read,
                [System.IO.FileShare]::Read)
            $mmf = [System.IO.MemoryMappedFiles.MemoryMappedFile]::CreateFromFile(
                $fs, [NullString]::Value, 0,
                [System.IO.MemoryMappedFiles.MemoryMappedFileAccess]::Read,
                [System.IO.HandleInheritability]::None, $false)
            $view = $mmf.CreateViewAccessor(0, 0,
                [System.IO.MemoryMappedFiles.MemoryMappedFileAccess]::Read)
            for ($p = 0; $p -lt [Math]::Min($view.Capacity, 65536); $p += 4096) {
                $null = $view.ReadByte($p)
            }
            $view.Dispose()
            $mmf.Dispose()
        } catch {
            "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') iter=$i file=$f error=$($_.Exception.Message)" | Out-File -Append $logFile
        }
        $i++
        if ($i % 50 -eq 0) {
            try {
                [GC]::Collect()
                [GC]::WaitForPendingFinalizers()
            } catch {
                "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') iter=$i GC error=$($_.Exception.Message)" | Out-File -Append $logFile
            }
        }
    }
}

"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Workload1582 starting (PID=$PID)" | Out-File -Append $logFile

try {
    1..2 | ForEach-Object {
        Start-Job -ScriptBlock $block -ArgumentList $logFile
    }

    while ($true) {
        $jobs = Get-Job
        $failed = $jobs | Where-Object { $_.State -eq 'Failed' }
        if ($failed) {
            foreach ($j in $failed) {
                "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Job $($j.Id) FAILED: $($j.ChildJobs[0].JobStateInfo.Reason)" | Out-File -Append $logFile
                Remove-Job $j -Force
                Start-Job -ScriptBlock $block -ArgumentList $logFile
            }
        }
        $running = @(Get-Job | Where-Object { $_.State -eq 'Running' })
        if ($running.Count -eq 0) {
            "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ALL JOBS DEAD, restarting" | Out-File -Append $logFile
            1..2 | ForEach-Object {
                Start-Job -ScriptBlock $block -ArgumentList $logFile
            }
        }
        Start-Sleep -Seconds 60
    }
} catch {
    "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') PARENT CAUGHT EXCEPTION: $($_.Exception.GetType().FullName): $($_.Exception.Message)" | Out-File -Append $logFile
    "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') STACK: $($_.ScriptStackTrace)" | Out-File -Append $logFile
} finally {
    "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') PARENT EXITING (PID=$PID) LastExitCode=$LASTEXITCODE" | Out-File -Append $logFile
}


---------8<-------------


Also here is my qemu cmd:

/usr/libexec/qemu-kvm
  -name vm-1,debug-threads=on
  -machine pc-q35-rhel9.6.0,usb=off,dump-guest-core=off,hpet=off,acpi=on
  -accel kvm
  -cpu host,hv-time=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x1fff,hv-vpindex=on,hv-runtime=on,hv-synic=on,hv-reset=on,hv-frequencies=on,hv-tlbflush=on,hv-ipi=on
  -m 16384
  -object memory-backend-ram,id=ram-node0,size=16G,host-nodes=0,policy=bind
  -numa node,nodeid=0,cpus=0-3,memdev=ram-node0
  -smp 4,sockets=1,dies=1,cores=4,threads=1
  -rtc base=localtime,driftfix=slew
  -global kvm-pit.lost_tick_policy=delay
  -device virtio-blk-pci,drive=drive0,write-cache=on
  -drive file=/mnt/nfs-fleet/vm-1.raw,if=none,id=drive0,format=raw,aio=native,cache.direct=on,discard=unmap
  -device virtio-net-pci,netdev=net0,mac=XX:XX:XX:XX:XX:XX,mq=on,vectors=18,host_mtu=9000
  -netdev tap,id=net0,ifname=tap1,script=no,downscript=no
  -device virtio-serial-pci
  -device virtio-balloon-pci
  -device virtio-rng-pci,rng=objrng0
  -object rng-random,id=objrng0,filename=/dev/urandom
  -device vmcoreinfo
  -vga virtio
  -serial unix:/tmp/serial-1.sock,server,nowait
  -qmp unix:/tmp/qmp-1.sock,server,nowait
  -display none
  -daemonize


which follows the issue reported in the virtio-win project:
https://github.com/virtio-win/kvm-guest-drivers-windows/issues/1582 


Thanks,
Al 


