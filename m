Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006747DD65
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580674; cv=none; b=Rvb/RRAQpL6djyNseI4TAfDNbwWDg8L3na16SHnHtnu8VuQPcErGK0+OwPYO2w9e0nZh83x7ayuOKbaW8pxQGhAC/RsJbqwpZQ36qofRRsWJIlkA1sgjoOAwebcNCrledRqtBnmOcn2x9CqBAZGc3BpL7zMLq9lNWZlP2g/EagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580674; c=relaxed/simple;
	bh=OYerxWK+A4BegStIfs3fucAbRGRI3Lum9KlgJ6ZfUYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NgUUdtSkGcJBc8/VaqF45hO5wN3TDmR3tWenp4ZlavzLpy9YttN3kALfFhheG3+oIQ7/ErRvZKrCNajuJ30/iOtwU64j7tSRd/sWrg7/+oSFN6Z2n2BLrYCV9ywNyJNV5Kx0HY28vDd+wNP7nYw/cITKDhQzq1KR0gAzSBV36QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVNmfg/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVNmfg/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1o0sZuvE7X9OzejDUo7wK0MyxBctCBc4E5xSa2kzXII=;
	b=IVNmfg/3YuOxhUe1rCxIpTu6L9cnZycIP8nRGHaMBht1p+Umf/bb1jRBqGP1U7jKHMxGMX
	9sHIRxF0ruq3XY34PfdRSoNlU0opEqFUSg2rWwXQnHqhmCRcm/RWxJTUkqFdvQK9ApirSo
	pGIZKAqf8XiHI3ejo1d3eEKmoXjGp18=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-KTuRvUm8PVa9FpJenqzRDA-1; Thu,
 04 Jun 2026 09:44:29 -0400
X-MC-Unique: KTuRvUm8PVa9FpJenqzRDA-1
X-Mimecast-MFC-AGG-ID: KTuRvUm8PVa9FpJenqzRDA_1780580665
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 201C81800586;
	Thu,  4 Jun 2026 13:44:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EF851800367;
	Thu,  4 Jun 2026 13:44:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v5 00/12] Make RamDiscardManager work with multiple sources
 & virtio-mem
Date: Thu, 04 Jun 2026 17:43:46 +0400
Message-Id: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0JmbU0LbU1ceQ/DgnYGWxPATJFoS
 O9uAZcvef/9FRJxpATXagWmJaY4jQXMqQIfuvFBImJhqGVtpVZaMA5GOIt93ViLVjZQ1BdTHz9
 75t4enN7uSX7etpsRYpon/u4/i968I2nkP7loIYXD3ioyF69I3ZgwdPPZTwO0Oecf8v74lasAA
 AA=
X-Change-ID: 20260414-rdm5-b6df2366d603
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OYerxWK+A4BegStIfs3fucAbRGRI3Lum9KlgJ6ZfUYs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEwDubNJ67iPsrVwwI2IS5sX2rM5wdaMBg23
 pizbMshfmqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMAAKCRDa6OEJdZac
 5SGVD/4xeNXyVOZx9guExB3JpI89n1XGWqurK9ZeriM1rwHQex81PKrZ58A/vUAMqVXrAPwCJuz
 ISn3k0F/QIyu7g6WkNMUBf1k3lZD4BjDoGtEjWFPLNz2mCG3IQlHu3Njs9hkkvJb1F4UNCh+wCN
 D6PBjYXkifsmqbkJrsIoXXQHQwkU2dgk4wSGhCNIylOGE7Rub5JbeZnqN2wkWnReKObNnJujDi5
 4FmZVjmxCc6Bbfrns1f3LtDZ/6ZqUM8tA4lDC1yAXt4QzVKiZE+jkqfuVpMJJYyGDk1cFaNV0KC
 WsTN9ba7cF+wwI2hnwlvDkQ2YAqn1tfQqvNqWV4v4iPky8URKrju7uix13HNk3EarA1KfZ/S/UW
 4+Ytf5U1vlqSqSR0xg1ZyYDNDVNfNulPO0C09TTtypLxtLe+I3IVvWsXufyyj796H6+ChYDPGQP
 k1XdbU5/LG69oR07/sCDRNQ4zmNlodFB8NzyazLQIZpngHhF4qabc4ll4qWuXkgiX2BsFHDyEDS
 5UU3nqTfwLLv4w9v1saZVerav4TtjwNJxy5r/a4zNXE0ebNjgHPt4o+M6FofgjtwvDvkfjOU8Z6
 9fJzxdmwISRcfFPKONmy4ThvzBPT4+9QIr5r2MtG3zjH+XlVg5+GX3CcZ1+D28546od87T97G7Z
 YSNtWnYCo/9tkOw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

This is an attempt to fix the incompatibility of virtio-mem with confidential
VMs. The solution implements what was discussed earlier with D. Hildenbrand:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238

The first patches are misc cleanups. Then some code refactoring to have split a
manager/source. And finally, the manager learns to deal with multiple sources.

This has been tested together with the Linux kernel series from
Zhenzhong Duan [1] for TDX guests.

(help fix https://issues.redhat.com/browse/RHEL-131968)

v5:
- explain why InterfaceClass in rust binding is not needed after
  moving RamDiscardSource
- drop extraneous added blank line
- replaced a runtime "if (has_rdm)"" with an assert()
- dropped "RFC: hw/virtio: start virtio-mem guest_memfd regions as
  shared", in favour of start-private memory approach from "[RFC PATCH
  0/6] Support virtio-mem memory hotplug in TDX guests" [1]
- demote "monitor: add 'info ramblock-attributes'" as RFC
- rebased and collected trailers

v4:
 - added "system/physmem: make ram_block_discard_range() handle guest_memfd"
 - added "monitor: add 'info ramblock-attributes' command"
 - added "RFC: hw/virtio: start virtio-mem guest_memfd regions as shared"
 - skip calling source in notify_populate (it may not have updated its
   internal state)
 - rebased, collected trailer tags

v3: issues found by Cédric
 - fix assertion error on shutdown, due to rcu-defer cleanup
 - fix API doc warnings

v2:
 - drop replay_{populated,discarded} from source, suggested by Peter Xu
 - add extra manager cleanup
 - add r-b tags for preliminary patches

- Link to v4: https://lore.kernel.org/qemu-devel/20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com

[1]: https://lore.kernel.org/lkml/20260604093551.1511079-1-zhenzhong.duan@intel.com/

---
Marc-André Lureau (12):
      system/memory: split RamDiscardManager into source and manager
      system/memory: move RamDiscardManager to separate compilation unit
      system/memory: constify section arguments
      system/ram-discard-manager: implement replay via is_populated iteration
      virtio-mem: remove replay_populated/replay_discarded implementation
      system/ram-discard-manager: drop replay from source interface
      system/memory: implement RamDiscardManager multi-source aggregation
      system/physmem: destroy ram block attributes before RCU-deferred reclaim
      system/memory: add RamDiscardManager reference counting and cleanup
      tests: add unit tests for RamDiscardManager multi-source aggregation
      system/physmem: make ram_block_discard_range() handle guest_memfd
      RFC: monitor: add 'info ramblock-attributes' command

 MAINTAINERS                                 |    4 +
 qapi/machine.json                           |   56 ++
 include/hw/vfio/vfio-container.h            |    2 +-
 include/hw/vfio/vfio-cpr.h                  |    2 +-
 include/hw/virtio/virtio-mem.h              |    3 -
 include/monitor/hmp.h                       |    1 +
 include/system/memory.h                     |  279 +-----
 include/system/ram-discard-manager.h        |  358 ++++++++
 include/system/ramblock.h                   |    5 +-
 accel/kvm/kvm-all.c                         |    2 +-
 hw/core/machine-hmp-cmds.c                  |   32 +
 hw/vfio/cpr-legacy.c                        |    4 +-
 hw/vfio/listener.c                          |   10 +-
 hw/virtio/virtio-mem.c                      |  259 +-----
 migration/ram.c                             |    6 +-
 system/memory.c                             |   88 +-
 system/memory_mapping.c                     |    4 +-
 system/physmem.c                            |   27 +-
 system/ram-block-attributes.c               |  328 +++----
 system/ram-discard-manager.c                |  612 +++++++++++++
 target/i386/kvm/tdx.c                       |    2 +-
 tests/unit/test-ram-discard-manager-stubs.c |   48 ++
 tests/unit/test-ram-discard-manager.c       | 1235 +++++++++++++++++++++++++++
 hmp-commands-info.hx                        |   13 +
 rust/bindings/system-sys/lib.rs             |    2 +-
 system/meson.build                          |    1 +
 system/trace-events                         |    2 +-
 tests/unit/meson.build                      |    8 +-
 28 files changed, 2569 insertions(+), 824 deletions(-)
---
base-commit: 405c32d2b18a683ba36301351af75125d9afda08
change-id: 20260414-rdm5-b6df2366d603

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

