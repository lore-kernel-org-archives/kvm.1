Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB44402455
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318958; cv=none; b=Yse3NyYRbtof0f5IZm+Q2BR2hFg+dZyo91Epo2NuxLWWZXffplpNMQkDF9RoIGu0yCBZTeinLMUZIDUrsr10jZJQbdMz4FYiGu8FTCx0lQC0aGB4ItMsESxZxFwyHCzVPYgZzcjURzplHcJxLWw5zCmxKevnsMWH+sFW+ip9ixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318958; c=relaxed/simple;
	bh=dJeoIAYC0cILfwsTzSiUsZ2WIJGKmi2Cbxeyu6ial4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ISEVriB0eOpwXpOA3qhfxy9NT4QkloFit4BeL905vVeBo6oabbSuVcdlYsN+9xWBowZddUjrYpv8ITeFZhy+iM3v1wwSBdci/bHHvAZv3jdTGCvBvbZLXyn7fWYQukxkpyb2mzf8jruTGeWeTY+fZWN2O6SUfnWRfh9K42DwsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f39IWY5P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f39IWY5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777318955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zdK+EUUHjdOp8sYOM/4o8Xc8d42cwjolKP4mkoiOi+w=;
	b=f39IWY5PA0hm5rZ4P+vktGr4mVgCnq+m/SNoYOT8F2hD2PZOWHoIVsOEBu33O83CBFMXvP
	eJsgHZ3ipA3kt5/1Fb38AYrmy4AHalPTGMFaG35rcgAHf2HCfk2pmgkgz5FzHntLcvVvTE
	Ayq/4EqTbtPKnT45eSmznzTUEGHFuDA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-pXqu-zsyOkOZ0slRxBWEMw-1; Mon,
 27 Apr 2026 15:42:32 -0400
X-MC-Unique: pXqu-zsyOkOZ0slRxBWEMw-1
X-Mimecast-MFC-AGG-ID: pXqu-zsyOkOZ0slRxBWEMw_1777318947
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0467E19560AA;
	Mon, 27 Apr 2026 19:42:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCD42195608E;
	Mon, 27 Apr 2026 19:42:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/41] Fix various QOM object life-cycle issues
Date: Mon, 27 Apr 2026 23:41:59 +0400
Message-Id: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3wpAMBSA8VfRubayEc2ryIXNwVH+7YyUvLvh8
 ldf3wWMjpChjC5weBDTMgfIOAI7NHOPgtpgUInKk0wVYlsm4ZE9C93aLjU615mUEPrVYUfn96r
 q37ybEa1/B3DfD977/DltAAAA
X-Change-ID: 20260427-qom-tests-9dcf3b969411
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 jag.raman@oracle.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 peterx@redhat.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Ninad Palsule <ninad@linux.ibm.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org, 
 Titus Rwantare <titusr@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5793;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dJeoIAYC0cILfwsTzSiUsZ2WIJGKmi2Cbxeyu6ial4s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUV8Svhx4wJY8eV5FxLPjbbpOCdELnlPu6q
 M+OCl1EXviJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5ZJID/46S/D9kDQit+CYg+Q9+kkdNgbW+Vak0z9KkhG9HjyyH9MBWRGvdgLuSwjazXEPn5d2Bf1
 YBtH1ASYUrH77iYpV+p9LQTP3kGwGIA/Z+LX43RkfIuY4aNZ2CNUpAWgLZoEigIRd+AJIwxhXej
 5QrNRlKTPSsXJP1oStq1Cc/9sY8DIgN9OZ7l37wye8nYzSXj6jlFslnBEJ70LUA6ntYSAmrSLdp
 Xlg1Puaa2VRFgn0/NDUbm/j4txR9wWowDyVNSgoj0IDc/Aw5kXmnZqXCcMhFbFh/3PVo18aV1wL
 bMOY3erCq9AK2ttsPjsoO689lvj8KNbXx+UKZq1G6S4Y2zLeYnDaPQTpx6teT9A8ze5DIQZ/DAi
 5U+n/ZenL43ybKoVUGzh4QrDu7tHoFpcziK2+VEZX91bUJmFiY1FAi3fZPaO3qvQLcA7Wk2fr+N
 iXUErlU07ERqCugTNp3ViYjZkG7WBUJ47Iynfkl+cgZ3/mcF5DVfARfItVybrDObRG0lqCnk1QR
 5yXxDmItCNx4SYpUJf3k29yBPw0/M1aF5OGWz3wuOdcSO7DE16FaC/gvrUbsBkSWTfu9E74MGtZ
 jwrkR+nOPcJZDE+a65ylovdTR7IBTRhaUgLBqxxln2YBms7CG4Ai3XMPB9y7VzmkVx35b5IXHSA
 E58vN+e67z4iNXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

After Markus's "Several QOM objects crash on introspection" report, I
started writing some unit test.

This series adds a new "qom-tests" qtest command that exercises basic QOM
object life-cycle: it instantiates all non-abstract object types, gets/sets
their properties, and unrefs them. This quickly surfaces leaks and crashes
that could otherwise be triggered at runtime via QMP qom commands.

The bulk of the series fixes the issues found by this test and ASan
help. Some of the patches are redundant with patches sent earlier on the
ML and marked as RFC, they should naturally be dropped during rebases,
but are added for completeness and to make sure CI pass after this
series in the meantime.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (41):
      hw/pci: handle missing bus in prop_pci_busnr_get
      chardev/char-socket: handle NULL addr in char_socket_get_addr
      hw/pci-bridge: handle missing parent in prop_pxb_uid_get
      hw/pci-host/i440fx: handle NULL bus in pci-hole64 getters
      hw/pci-host/q35: handle NULL bus in pci-hole64 getters
      hw/remote: check visit return in vfu_object_set_socket
      qom: skip link property check callback when clearing link
      hw/intc/apic: guard against NULL cpu in set_id
      RFC hw/remote: guard listener unregister in finalize
      backends/cryptodev-lkcf: skip cleanup when not initialized
      RFC io/net-listener: move mutex init to instance_init
      RFC net/colo-compare: guard finalize against uninitialized state
      RFC system/ioport: move embedded memory region cleanup to portio_list_destroy
      ui/console: remove console from global list on finalization
      hw/i386/x86: free oem_id and oem_table_id on finalization
      hw/core/machine: free shim_filename on finalization
      hw/core/resetcontainer: free children array on finalization
      net/filter: free old values in property setters
      ui/console-vc: destroy fifo on text console finalization
      target/i386/sev: add finalize functions and fix leaking setters
      target/i386/kvm/tdx: free strings in tdx_guest_finalize
      hw/i386/nitro_enclave: add instance finalize
      net/can: free ifname on socketcan finalization
      backends/igvm-cfg: free filename on finalization
      scsi/pr-manager-helper: free path on finalization
      accel/kvm: free device path on finalization
      system/qtest: free log path on finalization
      hw/i386/pc: free pcspk on finalization
      hw/fsi: move OPBus address space init to realize
      hw/gpio/pca9552: fix state_str leak in pca955x_set_led
      hw/arm/aspeed: free fmc_model and spi_model on finalization
      hw/tpm: free PPI buffer on finalization
      hw/arm/sbsa-ref: free unrealized flash devices on finalization
      hw/arm/virt: free flash devices and OEM strings on finalization
      hw/loongarch/virt: free flash devices and OEM strings on finalization
      hw/ppc/spapr: free host_model and host_serial on finalization
      hw/ppc/pnv: drop extra ref on PHB after adding as child
      target/riscv: fix general_user_opts hash table leak
      hw/riscv/virt: free flash devices and OEM strings on finalization
      hw/i2c/pmbus: fix undefined behavior in pmbus_direct_mode2data
      qtest: add "qom-tests" command

 tests/qtest/libqtest.h              |  8 ++++++
 accel/kvm/kvm-all.c                 |  8 ++++++
 backends/cryptodev-lkcf.c           |  4 +++
 backends/igvm-cfg.c                 |  1 +
 chardev/char-socket.c               |  4 +++
 hw/arm/aspeed.c                     |  9 +++++++
 hw/arm/sbsa-ref.c                   | 12 +++++++++
 hw/arm/virt.c                       | 14 ++++++++++
 hw/core/machine.c                   |  1 +
 hw/core/resetcontainer.c            |  3 +++
 hw/fsi/aspeed_apb2opb.c             | 31 +++++++++++++++------
 hw/gpio/pca9552.c                   |  2 +-
 hw/i2c/pmbus_device.c               |  4 +--
 hw/i386/nitro_enclave.c             | 11 ++++++++
 hw/i386/pc.c                        | 10 +++++++
 hw/i386/x86.c                       |  9 +++++++
 hw/intc/apic_common.c               |  2 +-
 hw/loongarch/virt.c                 | 14 ++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  8 +++++-
 hw/pci-host/i440fx.c                | 15 +++++++++--
 hw/pci-host/q35.c                   | 15 +++++++++--
 hw/pci/pci.c                        | 11 ++++++--
 hw/ppc/pnv.c                        |  1 +
 hw/ppc/spapr.c                      |  2 ++
 hw/remote/remote-obj.c              |  4 ++-
 hw/remote/vfio-user-obj.c           |  4 ++-
 hw/riscv/virt.c                     | 14 ++++++++++
 hw/tpm/tpm_tis_sysbus.c             |  9 +++++++
 io/net-listener.c                   |  9 ++++++-
 net/can/can_socketcan.c             |  8 ++++++
 net/colo-compare.c                  | 31 +++++++++++----------
 net/filter.c                        |  2 ++
 qom/object.c                        | 10 ++++---
 scsi/pr-manager-helper.c            |  1 +
 system/ioport.c                     |  4 ++-
 system/qtest.c                      | 54 +++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c               |  5 ++++
 target/i386/sev.c                   | 37 +++++++++++++++++++++++++
 target/riscv/cpu.c                  |  7 +++++
 tests/qtest/libqtest.c              |  6 +++++
 tests/qtest/qom-test.c              | 12 +++++++++
 ui/console-vc.c                     |  1 +
 ui/console.c                        |  6 ++++-
 43 files changed, 379 insertions(+), 44 deletions(-)
---
base-commit: aa15257174da180c6a8a9d58f87319cfe61c5520
change-id: 20260427-qom-tests-9dcf3b969411

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

