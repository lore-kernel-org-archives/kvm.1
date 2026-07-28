Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890A39CCFD
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258850; cv=none; b=H41JT1N4bypjnGIt0QvBzCWrw+u3be2u61Mrq4tER1bb2b5TmspNJ/98nsPuJlZchkgaH+MkFvdHuOv5FD4VZN0faU8MmxbpCu9t74pwUsMFbLi/P6b0Xd4QWMQRLhaLDNVqphBNdmY9TfVqpBqvr8al+3F1TMduL1YKJJlrWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258850; c=relaxed/simple;
	bh=xy5zeg0ltZJiUTUz/WsVB85WkbaYfwIlv2J4z6pLjew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkaSQWG2hdVS0tWd4JseYNwOAlrMkPSVbLoVAkc2SYYALeqXi4h/XVaAa1hyoC+hQ4Uw30b+CCNlAGiP/Ctt9L3+1MtrkNmdoHNOzcRvuaL9PdHEW+eLfLrTcexC4e21FNBbX3vEHElQkPEY+LVOm3ahGtJkJvxsJv4TdNaN8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIcqBFX7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIcqBFX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785258848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JmAwDqluDtoqvo2+cTeG2W1PAu22MkFuh3GU3CAxJ4=;
	b=gIcqBFX7AxMfHhSp5ge1Emdbj2hVoGB4OGAB2UdoNceWd1uJtl1RTOkDKwVzDn334FqrZe
	rO8Ak9qfElfO8u+TsMn6mROYNJ+6WgEorzyFA9XJ/+zjwvH9eT8P3c8Z9Brj0kyqOzmTeR
	MOuZOI46vI35O5hcDZR8tbD67sSTE3o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-HFwpuFpZNcihG9pZFAcS7g-1; Tue,
 28 Jul 2026 13:14:04 -0400
X-MC-Unique: HFwpuFpZNcihG9pZFAcS7g-1
X-Mimecast-MFC-AGG-ID: HFwpuFpZNcihG9pZFAcS7g_1785258843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AB4119560B7;
	Tue, 28 Jul 2026 17:14:03 +0000 (UTC)
Received: from alougovs-mac.redhat.com (unknown [10.44.33.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D6E3180044F;
	Tue, 28 Jul 2026 17:14:00 +0000 (UTC)
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
Date: Tue, 28 Jul 2026 19:13:56 +0200
Message-ID: <20260728171356.96405-1-alougovs@redhat.com>
In-Reply-To: <ameuTMWJUZfleIbk@tycho.pizza>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jul 27, 2026 at 01:23:03PM -0600, Tycho Andersen wrote:
> Can you share the code for the mmap + disk io + DB content generator?
>
> We're looking at this and would like to reproduce.

Hi Tycho,

Sure, here's everything below.

The setup is a Windows Server 2022 guest on QEMU/KVM with Driver
Verifier enabled (/standard /all, which includes Special Pool).  All
three workloads run concurrently inside the guest.

1) Memory-mapped file workload (PowerShell, runs as a scheduled task)

Two concurrent background jobs, each in an infinite loop: pick a
random system DLL, read it into a byte array, create a memory-mapped
file from it, touch pages through the view accessor, then dispose.
Every 50 iterations, GC.Collect() forces the CLR to finalize all the
disposed mappings at once, which triggers a burst of PTE teardowns in
the Windows memory manager - in theory that should put some pressure on the TLB.

--- 8< --- workload-1582.ps1 ---
$ErrorActionPreference = 'Stop'
$logFile = "C:\drivers\workload-1582-errors.log"

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

$block = {
    param($files, $logFile)
    $i = 0
    while ($true) {
        $f = $files[(Get-Random -Maximum $files.Count)]
        try {
            $bytes = [System.IO.File]::ReadAllBytes($f)
            $ms = [System.IO.MemoryStream]::new($bytes)
            $mmf = [System.IO.MemoryMappedFiles.MemoryMappedFile]::CreateFromFile(
                $f, [System.IO.FileMode]::Open, $null,
                0, [System.IO.MemoryMappedFiles.MemoryMappedFileAccess]::Read)
            $view = $mmf.CreateViewAccessor(0, 0,
                [System.IO.MemoryMappedFiles.MemoryMappedFileAccess]::Read)
            for ($p = 0; $p -lt [Math]::Min($view.Capacity, 65536); $p += 4096) {
                $null = $view.ReadByte($p)
            }
            $view.Dispose()
            $mmf.Dispose()
            $ms.Dispose()
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

"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Workload1582 starting" | Out-File -Append $logFile

1..2 | ForEach-Object {
    Start-Job -ScriptBlock $block -ArgumentList (,$files), $logFile
}

while ($true) {
    $jobs = Get-Job
    $failed = $jobs | Where-Object { $_.State -eq 'Failed' }
    if ($failed) {
        foreach ($j in $failed) {
            "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Job $($j.Id) FAILED: $($j.ChildJobs[0].JobStateInfo.Reason)" | Out-File -Append $logFile
            Remove-Job $j -Force
            Start-Job -ScriptBlock $block -ArgumentList (,$files), $logFile
        }
    }
    Start-Sleep -Seconds 60
}
--- 8< ---

Register as a startup task:

  schtasks /create /tn Workload1582 /sc onstart /ru SYSTEM /f ^
    /tr "powershell.exe -ExecutionPolicy Bypass -File C:\workload-1582.ps1"

2) Disk I/O (DiskSpd, runs as a scheduled task)

Single-threaded, 32 outstanding I/Os, 64K block size, 50/50
read/write, 128MB file, loop forever.

--- 8< --- diskspd-loop.cmd ---
:loop
C:\drivers\diskspd.exe -d604800 -t1 -o32 -b64K -w50 -Sh -c128M C:\diskspd-io.dat
goto loop
--- 8< ---

DiskSpd binary: https://github.com/microsoft/diskspd/releases

Register:

  schtasks /create /tn DiskSpdIO /sc onstart /ru SYSTEM /f ^
    /tr "C:\drivers\diskspd-loop.cmd"

3) SQL stress (host-side script, drives queries into the guest)

SQL Server Express 2022 runs inside the guest.  The database
(StressDB, SIMPLE recovery model) has a single table with ~1.6M rows:

  RandomData (
      ID    INT IDENTITY PRIMARY KEY,
      Col1  UNIQUEIDENTIFIER,
      Col2  NVARCHAR(100),
      Col3  NVARCHAR(100),
      Col4  NVARCHAR(100),
      Col5  DATETIME2,
      Col6  FLOAT,
      Col7  BIGINT,
      Col8  VARBINARY(200)
  )

In our setup the database is baked into the golden VM image, so we
don't have a standalone creation script.  To reproduce, seed random
data and double via INSERT...SELECT until you reach ~1.6M rows.  The
exact count doesn't matter much — it just needs to be larger than the
SQL Express buffer pool (1.4 GB) so that queries cause constant cache
misses and disk I/O.

The host runs 3 sqlcmd streams per VM, 75% writes / 25% reads:

--- 8< --- sql-stress-75w.sh ---
#!/usr/bin/env bash
SQLCMD=/opt/mssql-tools18/bin/sqlcmd

query_stream() {
    local TARGET=$1
    while true; do
        case $((RANDOM % 4)) in
            0) Q="SET NOCOUNT ON; DECLARE @s INT = ABS(CHECKSUM(NEWID())) % 2800000 + 1; UPDATE StressDB.dbo.RandomData SET Col2 = REPLICATE(N'X', 90 + ABS(CHECKSUM(NEWID())) % 10), Col3 = REPLICATE(N'Y', 90 + ABS(CHECKSUM(NEWID())) % 10), Col5 = SYSDATETIME(), Col7 = ABS(CHECKSUM(NEWID())) WHERE ID BETWEEN @s AND @s + 50000" ;;
            1) Q="SET NOCOUNT ON; DECLARE @s INT = ABS(CHECKSUM(NEWID())) % 2800000 + 1; UPDATE StressDB.dbo.RandomData SET Col4 = REPLICATE(N'Z', 90 + ABS(CHECKSUM(NEWID())) % 10), Col6 = RAND(CHECKSUM(NEWID())) * 1000, Col8 = CAST(REPLICATE(0x42, 100 + ABS(CHECKSUM(NEWID())) % 100) AS VARBINARY(200)) WHERE ID BETWEEN @s AND @s + 50000" ;;
            2) Q="SET NOCOUNT ON; DECLARE @s INT = ABS(CHECKSUM(NEWID())) % 2800000 + 1; UPDATE StressDB.dbo.RandomData SET Col2 = REPLICATE(N'W', 90 + ABS(CHECKSUM(NEWID())) % 10), Col5 = SYSDATETIME(), Col7 = ABS(CHECKSUM(NEWID())), Col8 = CAST(REPLICATE(0x43, 150) AS VARBINARY(200)) WHERE ID BETWEEN @s AND @s + 50000; CHECKPOINT" ;;
            3) Q="SET NOCOUNT ON; DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS; CHECKPOINT; SELECT TOP 5000 ID, Col2, Col3, Col4, Col8 FROM StressDB.dbo.RandomData WITH (NOLOCK) WHERE Col7 > ABS(CHECKSUM(NEWID())) % 2000000000 ORDER BY Col5 DESC" ;;
        esac
        $SQLCMD -S "$TARGET" -U sa -P 'TestPass123!' -C -Q "$Q" -t 120 > /dev/null 2>&1
    done
}

echo "Starting 3 streams per VM (42 VMs = 126 streams)..."
echo "75% writes (cases 0,1,2): UPDATE 50K rows with wide columns + CHECKPOINT on case 2"
echo "25% reads (case 3): DROPCLEANBUFFERS + CHECKPOINT + table scan"
for N in $(seq 1 42); do
    IP="192.168.100.$((10 + N))"
    query_stream "$IP,1433" &
    query_stream "$IP,1433" &
    query_stream "$IP,1433" &
done
wait
--- 8< ---

On top of all that, Windows Defender runs a full scan of all drives
every 30 minutes via a scheduled task.

Al

