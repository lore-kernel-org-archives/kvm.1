Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B2311946
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732042; cv=none; b=CjW6K7JLPwqg2Hy0HQ2Rtc+KvZVWpFIQqRMgBRq9tqeUGhwuuvykFt3JgeVzmYeoUBKpw8Si4fDSEmckAOT3IzGNBm09i407WpnXBBxpVR9i5+/9DMbZo2EnjuK0EOkQm4lIw7NxAj//lzBb1cP5ieT1Gp2ZqjA4p179emsjTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732042; c=relaxed/simple;
	bh=Li7Jo8dN2xoUtKx5AP8Wk4qhOFXcY7UFgIx0Uqe64pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyOZZLy1oR8t69xeEssu4Xke9UT2XXQIpmI2FVtfC4RRBlUoKe0yzXbMP7GyshXRfmHwB2RrNYzF8idaY0ORJvqCLBpmJqoDBW2BHOD4gpHga+U2JPFjrK0s0Drvox3W+RmXzAxTB5R27tYYZ42Ip582QGmgzlNKEwsG/AyuV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPAxBqG4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfhZilT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPAxBqG4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfhZilT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782732039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mUoE78uEr8FhHed00+iIsGrol/Mlui/t1hgbZIjGR0A=;
	b=YPAxBqG4596M5rQ8B4VmDMc9OVeopscdr0f5+DwZVRWfpkD9kbEwxYBz/H8tOe+R01ILlF
	fB9301osyegvKrpLmIK/k/JOTh+3r5nh+6U4h5ogiifa93wUbecuiM1nTxdlwdyU4zom7B
	SiAVH6sqcabrKrmsBAAP8xUf4k7vIDk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-lgAMFyItNqmixUe40YRSjw-1; Mon, 29 Jun 2026 07:20:38 -0400
X-MC-Unique: lgAMFyItNqmixUe40YRSjw-1
X-Mimecast-MFC-AGG-ID: lgAMFyItNqmixUe40YRSjw_1782732037
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473bc66c837so646032f8f.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782732037; x=1783336837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUoE78uEr8FhHed00+iIsGrol/Mlui/t1hgbZIjGR0A=;
        b=BfhZilT7sX1o0H8RTx+E7rIElmcSj65dKNGhboKxf4RbPfwIthEXPMpNhRY3haHkOu
         CAvaDWnFR4c9ZU58a0puJFHAbzkovqEDCOcGE9hrfnX+ay8s+IMwVO/2ObxNTcctdFV1
         UwhxqYvFjDh7xbo9u+IfdWap1amjKPF9nRp6ovDqXReen323a0Xpw/5YQr9q066bFzEO
         BV+/w/PrDvsBcGJ+HcXv4B6rR+95JiV231FEGFL3fb4OeIeyhnk3HNB9HKFEQg3/J1gZ
         LRQYzRtx6I4SHo1F2Fp0w9J/2SJ11oEwOlDQBQpAsbebseagM0Mj7HfA1C1K3/TLKJBT
         ktBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732037; x=1783336837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUoE78uEr8FhHed00+iIsGrol/Mlui/t1hgbZIjGR0A=;
        b=eLcVn6If+DetZrpC5JGbtHBijCsD7BrNG1VSH2dGup4ACYDQB1wro1OuhO6XCGsjwc
         i4UERICC9eUdMLPfck95Uiqg7szNYemWINtVzfv5EVQ+EO1ZI5192WZ5R+6oeJEBfSQV
         tUWULVCFJpBaEl7PdLIMdTlJ48O2ZfhosjS/ajpBd7C7phpVUGKBE/sVF+Q8nFw4eNth
         gPmzY4rkJl1DQvFEaOJjwhuj71kApXzUQLSKrwSk9YMm4b1QQGMWjOnd5ARX73JrlFN1
         KC9j+rfbgtFxuE/l3Gh2QEA49zXr0O55kiopGUQ2C4JxtQdEAkoL8+CO0j/ahxO9A4eU
         s9fg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0bqmTc9DKOrrciKgi3bYB1UzZyU/3Q01k8dyGSvrWqBqV18lXbG71A5BoDkmz3LYphWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8OIr68CnWcTgpYbawTkhS2rVePG9cBCvPhSVPWiuWTlFsSio
	UUiLuIqQ+IqPogKf3OjaAFTCpOfWH/G70bas+Am/kO74Dsgsdc6sY1KJQOK5BZWEYOJJAkMQDoJ
	nj0Y1zFLLUml1N7re4zqTONiXyThIInS61Wfqdfctinc7LjNILEO6Hw==
X-Gm-Gg: AfdE7cltmRw8/UA73lwUny5f9hYg/4TUq5PUhVEecEZBo89OitEvWr7bgG6jivg9She
	GA8moIoQgJjW9rxz0NRwQprqHuQViWbmlS7UeQgK22/Xjv4qPp1z+Ha/jWqhnuis92z0Ios8HdG
	7fashs3CAxFtNy5kVqF6yYnCza7dEoC9falTLPwZCqZZqwb0JhvgBNS2XjadnVyNCjGcD6182bu
	eWh78dWIXLHtfdPtd4WoW/qfzxsTfZwr8nLy/3Ubg5fXD4Dd/QXwzJORp9hwGxzxHQ6NN8YykX8
	I2thL/N2pvIPecSOM0oRp2IJhqk8zVKwqLer/aQGzRZl6Fa13LM/PKUAXvDzHdlthx2q1ZzxWs5
	6EWFNETuCBhbYjuQl3clvUgbWBd3wqRWkFMhnzfNIqPZGrc+LqA==
X-Received: by 2002:a05:6000:2dc7:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-474fefa759emr36885f8f.14.1782732036684;
        Mon, 29 Jun 2026 04:20:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc7:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-474fefa759emr36831f8f.14.1782732036158;
        Mon, 29 Jun 2026 04:20:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm55320538f8f.11.2026.06.29.04.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:20:35 -0700 (PDT)
Message-ID: <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
Date: Mon, 29 Jun 2026 13:20:34 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260629110411.3051274-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/26 13:04, Aditya Gupta wrote:
> In the past there have been hard to recreate issues where XIVE changes
> cause qemu crashes due to multi-socket interrupts such as in [1].
> 
> Add a functional test explicitly to test whether remote interrupts work.
> 
> The test can also work as additional boot test for multi-socket boot,
> initrd boot test, as well as a check for e1000e to be working in powernv,

you should consider moving to a more modern nic model: igb, which
has sr-iov support too.

C.

> though that's not a target goal, and are additional benefits.
> 
>  From docs/system/devices/net.rst:
> 
>    In order to check that the user mode network is working, you can ping
>    the address 10.0.2.2 and verify that you got an address in the range
>    10.0.2.x from the QEMU virtual DHCP server.
> 
> Hence use 10.0.2.2 with ping.
> 
> [1]: https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/
> 
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index 0ea6c93e4287..9760f58ee41e 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -9,6 +9,7 @@
>   
>   from qemu_test import LinuxKernelTest, Asset
>   from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   class PowernvMachine(LinuxKernelTest):
>   
> @@ -27,6 +28,17 @@ class PowernvMachine(LinuxKernelTest):
>            'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
>           'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
>   
> +    def shell_exec_command_check_fail(self, command):
> +        fail_msg="Fail"
> +        self.shell_exec_command(f"export __FAIL_MSG={fail_msg}")
> +
> +        # If the exit code for the command is non 0, print fail message
> +        command = command + " || echo $__FAIL_MSG"
> +        exec_command_and_wait_for_pattern(self, command, '#', fail_msg)
> +
> +    def shell_exec_command(self, command):
> +        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
> +
>       def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>           self.require_accelerator("tcg")
>           kernel_path = self.ASSET_KERNEL.fetch()
> @@ -71,6 +83,89 @@ def test_linux_smt_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_linux_remote_interrupts(self):
> +        self.require_accelerator("tcg")
> +        self.set_machine('powernv')
> +
> +        # Have below setup in this test:
> +        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
> +        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
> +        # 2. CPU on 2nd socket (chip 1) disabled
> +        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
> +        #
> +        # Then ping is done, to generate interrupts from e1000e which should go
> +        # to IRQ server on the remote sockets
> +        self.vm.add_args('-smp', '4,sockets=4,threads=1')
> +        self.vm.add_args('-netdev', 'user,id=net0')
> +        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_INITRD.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +            '-drive',
> +            f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
> +            '-append', 'root=/dev/nvme0n1 console=hvc0',
> +            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
> +        self.vm.launch()
> +
> +        # Wait for boot to complete
> +        console_pattern = 'CPU maps initialized for 1 thread per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 4 nodes, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process',
> +                                 self.panic_message)
> +
> +        # Wait for login prompt and login as root (no password in buildroot)
> +        wait_for_console_pattern(self, 'login:', self.panic_message)
> +        exec_command_and_wait_for_pattern(self, 'root', '#', self.panic_message)
> +
> +        # e1000e is connected to socket 1, disable the CPU on socket 1
> +        self.shell_exec_command("echo 0 > /sys/devices/system/cpu/cpu1/online")
> +        self.shell_exec_command(
> +            "export CPU1_STATE=$(cat /sys/devices/system/cpu/cpu1/online)")
> +        self.shell_exec_command_check_fail("[ $CPU1_STATE -eq 0 ]")
> +
> +        # RX, TX interrupts to chip/cpu 2 & 3 respectively
> +        self.shell_exec_command(
> +            "export RX_IRQ=$(awk '/eth0-rx/ {print $1}' /proc/interrupts | tr -d ':')")
> +        self.shell_exec_command(
> +            "export TX_IRQ=$(awk '/eth0-tx/ {print $1}' /proc/interrupts | tr -d ':')")
> +        self.shell_exec_command("echo 2 > /proc/irq/$RX_IRQ/smp_affinity_list")
> +        self.shell_exec_command("echo 3 > /proc/irq/$TX_IRQ/smp_affinity_list")
> +
> +        # Capture interrupt counts before generating traffic
> +        self.shell_exec_command(
> +            "export RX_BEFORE=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
> +        self.shell_exec_command(
> +            "export TX_BEFORE=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
> +
> +        # Wait up to 15 seconds for eth0 link to come up
> +        self.shell_exec_command(
> +            "c=0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do "
> +            "sleep 1; c=$((c+1)); [ $c -gt 15 ] && break; done")
> +
> +        self.shell_exec_command_check_fail(
> +            "ip addr show eth0 | grep 'inet 10.0.2'")
> +
> +        # Generate network traffic to trigger remote interrupts
> +        # Ping QEMU's user-mode network gateway (10.0.2.2)
> +        self.shell_exec_command("ping -W2 -c5 10.0.2.2")
> +
> +        # Show final interrupt counts to verify remote interrupts occurred
> +        self.shell_exec_command("cat /proc/interrupts | grep eth0")
> +
> +        # Verify interrupt counts increased (whether interrupts were delivered)
> +        self.shell_exec_command(
> +            "export RX_AFTER=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
> +        self.shell_exec_command(
> +            "export TX_AFTER=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
> +
> +        # Check that interrupt counts increased
> +        self.shell_exec_command_check_fail("[ $RX_AFTER -gt $RX_BEFORE ]")
> +        self.shell_exec_command_check_fail("[ $TX_AFTER -gt $TX_BEFORE ]")
> +
>       def test_linux_big_boot(self):
>           self.set_machine('powernv')
>           self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')

