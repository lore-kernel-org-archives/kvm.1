Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586125;
	b=zK5629eHlcQ4GJYM+MKSvXdlO0hLlPBqq+ywoK5BgNjUAPzjcyk6Pv9frFZxKZaaU2PP
	 EEhqjkXKp1K5iM7DMDENmzOxfGBfMKhIhAFt0YwTG9ww13nFYKlIEWVP2f6XBnzLZZZ1G
	 S8UlyyIUVrnZiSlA/SNN5jtITrNgP6iD6XYRCVH1S2UyvSevPscHsglcEdHw0dptQTIns
	 uTGZMpbGtbIhfFukKSw904huM2b1wBWxG1Sa0zkQQ1SwnTx8qkRmGEgB6P4jYH2wvEpSr
	 i5NeWfHGY9NzrjbxxunfFoXQZWvSwtMcSxn1BLgZG3RxGDpKKVPM6RxEDtKkRyXwXpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c8TFvUX1hEZOaHnYgxRbDWuNTMm4qLIKVwFQcFF2K+4=;
	b=iB2AL6czYy3prPtcw4EJZLic1HYZNUvTPSUJa0AZabYAQKBCICMvFuT5Ggwi4uuSrDR2
	 luWRlxAprLP0t/QtOj2A833xmA+HfNyWBkbB2UadfZVhudVz93ipLMX8SbLvUHZOelJo7
	 klsBhW67ngQqw9BnzUQ5Q7CMQn548ggbHYsqfQCSCY0B7k7TNVfb5fpmOm31t+z3V+lfr
	 XwXsobzDkUdTZ9bcGs4bEz1BSvxWRHI2XYBvmjlhbBpxY8gjJXd1M4eu9w+tHNjf74MyY
	 OU4GsG3fjLdT6rsbpeC6TPil6jhKLRQ3AuGHu40uuECrZO44KW7QOaxu6Xgck94k8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=DaTcV7eJ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB69606EBA3
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB69606EBA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=DaTcV7eJ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so89425e9.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794586123; x=1795190923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c8TFvUX1hEZOaHnYgxRbDWuNTMm4qLIKVwFQcFF2K+4=;
        b=DaTcV7eJhctQsQ3BcKcHVi3tLOUumD7GnJBDEv7djL3j8w3f72wwfZVIpS0uK0RXfW
         tkARLM3sZA4Tz4utgrouoc+1oaUWpsy4SA7Z9rhOAYe0vCasT428FSkA/7BIkFOEtnSQ
         A3Wmcwadjh+YbWrsJwmCL8+kC7JVOFPj++2ZHdDL9str4SyPoypkoaMFtPmW0opVsO4M
         NDgSP+4N4Ch1NOTxRZGIUx+3PgIC5BB67iAjc5eWkVNh3CwZO5XoThIvSq0JO4b4KI30
         JKVVpbeQjgmQmUu4DI/jm2kT7TpaLUVlMJa0fdiyPq+vvBzThxZ8olxG6xOwRbTalz00
         nu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586123; x=1795190923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c8TFvUX1hEZOaHnYgxRbDWuNTMm4qLIKVwFQcFF2K+4=;
        b=B6JOMfKWi1iLDdbA54ojpivAWEryLNjjp1yr1YgfH4+j1VXMC+Jj6MlHweixsqaLwo
         sHi2su9OBa06DOURODDjIopEplLhPLlhQAhz9/Q0HE6P2+P/Y+P+oBBGUpxqPk0POVHm
         Wd9W04k0Lt5jp41b8MgCdbYPirCR+y6ipiEkhOMSZueyqi7a/skieXCFB5vcJsxEbaPp
         emeSI+4o3PNiLDPGaQ5umGJcU1lVW5nLCcDiPVsMr08rwMA5NaNfU8FjHzrvfPMy7s7x
         a46qqbkxhiyaBKzayiG+5d0GKhkdjiu8u/IJbPasRV0E8jUwAkJmJ+a2i1vP8d+PhjTi
         HBVw==
X-Forwarded-Encrypted: i=1; AL+hErG8qTeoNXANwg+jS58/6sfL5BtYeCB+DNX+ft+FKtA8HpuD7rUO7H2cS7P/Z0WOASgqfdY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b2k0KYdayf7djB4rpJlfVDMwuQCKE7Ni+IQkzwalutpl8Jrdr
	1S7pBqTSObVjHxAQGhiM7Q8qoOxO6cHLRl40Z5Py2DePGa3mihvYbdJQKwl26IQSQGo=
X-Gm-Gg: AYBFou1C5X5SHUN/BQY1tB+t/zTOskxy8ILnXt2WZX9MFybfLkAkknAj2/rvSrVdImg
	hjvJINbCSzQe53tw3s8kR9akVJyDP6mj0h3Ad/vZBa+BjvyeuJNrLzuq2o9Eh78tjKpZ9OMlNct
	i1benSmCXTQHa6clgzX1pVe7rEb9Lz8tRKU0+yYwVIojVdqrtIVkJD0mgAL7deii41ImxuyoZ3n
	v7zF1drNZpetpJYuOEP0NehORvv7kVxIgjZ6i6Y3ATvAGelXa0Xik9GXFZUgz9v5oK9gymKdNmp
	Kuq91X+96l+mgwxi7468IecbsH0UQf4+oMWNtdvd1tzvAyu+UdMlylKLcKUGEb7nBoqmY5UG5lj
	pS3XEf+yh5NWoz1tKFO8/dxtAvdi/GwgXuZCcCLi5eBIKPb050LJexk52w8R0L5AJdaZDTCkcdz
	R9Lq4jWLwxnWuO+DYMjE9WY58kMTYpc7AXW8sxB+i1Vt8eOO/dSXh060FlJDftaRNaSFuVcjeAW
	/iROiFRTqVGWZOlBQ4SSm3fy2GbkC0T/lCd9B4keoBbcjiQnmiML+P6POdKJIG9Oj+yofzByo5i
	akQemDxrrU8P3Z3YXPgAQTvUxe8kvnfNG9hCe2UC
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb55c5f579mr61042745e9.2.1794586122529;
        Fri, 13 Nov 2026 08:08:42 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm68947475e9.13.2026.11.13.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:08:41 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jgg@ziepe.ca,
	david.quigley@intel.com,
	lukas@wunner.de,
	ksinyuk@kernel.org,
	rodrigo.vivi@intel.com,
	cedric.xing@intel.com,
	sameo@meta.com,
	drdeeglaze@gmail.com,
	James.Bottomley@HansenPartnership.com,
	aik@amd.com,
	jpiotrowski@nvidia.com,
	qinkun@google.com,
	pgonda@google.com,
	jic23@kernel.org,
	alistair.francis@wdc.com,
	ankita@nvidia.com,
	suzuki.poulose@arm.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	peter.fang@intel.com,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	yeoreum.yun@arm.com,
	aneesh.kumar@kernel.org,
	dave.jiang@intel.com,
	nik.borisov@suse.com,
	sergii.dmytruk@3mdeb.com
Subject: [PATCH RFC v2 0/9] attestation: Add a common subsystem and TDX support
Date: Fri, 13 Nov 2026 17:08:29 +0100
Message-ID: <20261113160838.2512652-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
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

From: Jiri Pirko <jiri@nvidia.com>

Linux has several attestation interfaces, each tied to one technology.
Extending a measurement takes device-specific flows for TPM, CCA, TDX
and SEV, none of them discoverable, and requesting a signed quote takes
another set, SPDM included. A new root of trust has no logical home
short of squeezing it into tsm_report and tsm_mr: tsm_report covers
reports alone, the MRs went to tsm_mr, and SPDM fits neither.

This series adds a common attestation subsystem. Its goal is to support
platform, TEE and device roots of trust through one model, including
TPM2, TDX, SEV-SNP, Arm CCA, FIRME, Caliptra and PCI/TSM-backed
devices, so that a program extends a register or asks for evidence
without knowing the hardware behind it. This first series implements
the common subsystem and a TDX provider. The native TDX interfaces,
/dev/tdx_guest, tsm_report and tsm_mr, stay as they are.

RFC v1 [1] posted this and CTLV as one patchset. For convenience, v2
splits it in two, and this series applies on top of the CTLV series,
posted alongside as

  [PATCH RFC v2 00/15] ctlv: Add a schema-driven TLV uAPI for character devices

Each attestation device has a node, /dev/attestation/attestationN,
that speaks CTLV: a request is checked against the family's schema and
executed at once, rather than assembled through several files. The
base family, ctlv-attestation, has what every provider shares, so a
tool written against it works with any provider. TDX's family,
ctlv-attestation-tdx, inherits it and adds no ops. It fills the base
family's extension points: device-get's info with the TD's MRCONFIGID,
MROWNER and MROWNERCONFIG, and evidence-vendor-format with the two TDX
Quote formats.

The base family's ops, as ctlvgen --signatures prints them, with the
purpose of each:

  # What the device supports, fixed for its life, and its family's fields.
  device-get() ->
      { caps: { evidence?: { objects[16]: { id, class, formats[4]?,
                                            vendor-formats[4]?, max-length,
                                            challenge-lengths[8]?: { length?,
                                                                     min-length?,
                                                                     max-length? } } },
                mr?: { flags } }, info: device-info }

  # Evidence: each object named, written to a blob the caller supplies,
  # a signed one made by the call over the challenge.
  evidence-get(challenge?, objects[16]: { id, data: out blob }) ->
      { results[16]: { format?, vendor-format?, length }, mr-generation? }

  # Describe every MR, or the one an ID names.
  mr-get(id?) -> { items[]: { id, mr-desc } }

  # One MR's values, a digest per bank, and the MR generation they
  # reflect.
  mr-read(id) -> { mr-generation, mr-values[hash-algo]: mr-value }

  # Extend banks of one MR by the caller's digests.
  mr-extend(id, mr-values[hash-algo]: mr-value) -> { mr-generation }

An mr-desc is an MR's name, its banks, what it allows and its register
index, and an mr-value one bank's hash algorithm and digest. The
userspace ABI gives each op's request, reply, errors and access.

On TDX, evidence-get returns the Quote over a 64-byte challenge,
labelled a legacy or a DICE one, and, where ACPI describes it, the
CCEL event log. The MRs are MRTD, which cannot be extended, and RTMR0
to RTMR3, all SHA-384. With ctlvctl from the CTLV series and
CTLV_SPEC_DIR pointing at Documentation/ctlv/specs, the simulator's
output, rewritten for a TD, its lengths left out:

  # The device and its family chain.
  $ ctlvctl list
  attestation/attestation0        ctlv/ctlv-attestation/ctlv-attestation-tdx

  # What it supports.
  $ ctlvctl exec attestation/attestation0 device-get
  # device-get, 1 fragment, generation 0
    device-get caps
      device-get caps.evidence
        device-get caps.evidence.objects
          device-get caps.evidence.objects.id 0
          device-get caps.evidence.objects.class signed
          device-get caps.evidence.objects.vendor-formats quote
          device-get caps.evidence.objects.vendor-formats quote-dice
          device-get caps.evidence.objects.max-length 131048
          device-get caps.evidence.objects.challenge-lengths
            device-get caps.evidence.objects.challenge-lengths.length 64
        device-get caps.evidence.objects
          device-get caps.evidence.objects.id 1
          device-get caps.evidence.objects.class event-log
          device-get caps.evidence.objects.formats ccel
          device-get caps.evidence.objects.max-length ...
      device-get caps.mr
        device-get caps.mr.flags extend
    device-get info
      device-info.mrconfigid hex:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
      device-info.mrowner hex:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
      device-info.mrownerconfig hex:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

  # A Quote over a 64-byte nonce, written to quote.bin.
  $ nonce=$(openssl rand -hex 64)
  $ ctlvctl exec attestation/attestation0 evidence-get --json \
          '{"challenge":"hex:'"$nonce"'",
            "objects":[{"id":0,"data":{"file":"quote.bin"}}]}'
  # evidence-get, 1 fragment, generation 0
    mr-generation 0
    evidence-get results
      evidence-get results.vendor-format quote
      evidence-get results.length ...

  # Every MR.
  $ ctlvctl exec attestation/attestation0 mr-get
  # mr-get, 1 fragment, generation 0
    mr-get items
      mr-get items.id 0
      mr-desc.name mrtd
      mr-desc.supported-hash-algorithms HASH_ALGO_SHA384
      mr-desc.caps 0
    mr-get items
      mr-get items.id 1
      mr-desc.name rtmr0
      mr-desc.supported-hash-algorithms HASH_ALGO_SHA384
      mr-desc.register-index 0
      mr-desc.caps extend
    ...

  # The value of RTMR0, MR 1.
  $ ctlvctl exec attestation/attestation0 mr-read id=1
  # mr-read, 1 fragment, generation 0
    mr-generation 0
    mr-values
      mr-value.hash-algo HASH_ALGO_SHA384
      mr-value.data hex:b57a300eac0c9b8593bafbadee812f8915456913c28010dab20d700446169bdd56e1af87ce94d66c8fd2d456b3e42826

  # Extend RTMR3, MR 4, by a file's SHA-384 digest.
  $ digest=$(sha384sum app.img | cut -d' ' -f1)
  $ ctlvctl exec attestation/attestation0 mr-extend --json \
          '{"id":4,"mr-values":[{"hash-algo":"HASH_ALGO_SHA384",
                                 "data":"hex:'"$digest"'"}]}'
  # mr-extend, 1 fragment, generation 0
    mr-generation 1

This series is the first part. The branch [2] has the whole work,
building on it: CTLV's events, the MR journal with IMA as its first
user, memfd and dma-buf evidence blobs, an mr-extend that hashes the
caller's data, evidence acceptance and device security, a simulation
provider, KUnit tests and selftests.

The series adds 3480 lines:

  attestation core, C               1340
  generated files                    770
  TDX provider, C                    470
  docs                               462
  family specifications              206
  ABI snapshots                      170
  registry, build                     62

Changes since RFC v1, each patch listing its own:

- Each evidence object has an ID, a class, signed or event-log, and
  the formats it may have: from evidence-format for a layout a
  standard defines, from evidence-vendor-format, whose values the
  device's family gives, for a vendor's. A signed object lists the
  challenge lengths it takes.
- evidence-get names objects by ID, may omit the challenge, and takes
  output blobs of any length, failing with the length one needs.
- TDX labels each Quote, returns the CCEL log, and leaves the
  TDREPORT to /dev/tdx_guest.
- The MR journal and its notifications are left out, until IMA uses
  the subsystem.
- mr-extend may extend some of an MR's banks, and every MR can be
  read.
- mr-get, a query, describes every MR or the one its optional id
  names, and mr-dump is gone.
- Attestation has its own class and /dev/attestation/ nodes, and the
  TDX provider is part of tdx-guest instead of a module of its own.
- The specs are written as op trees and records, with a comment on
  every item, and a userspace ABI document describes the family.

The patches:

  1      the base family's specification and generated files
  2      the userspace ABI
  3-5    the provider and instance core, the MRs, and the CTLV ops
  6      how to write a provider
  7      tdx-guest's native attestation service, for the provider
  8-9    the TDX family's specification and implementation

Note to reviewers: the uAPI, in 1 and 2, and the provider API, in 3
and 6, matter most at this stage.

[1] https://lore.kernel.org/all/20261015145053.3664509-1-jiri@resnulli.us/
[2] https://github.com/jpirko/linux_mlxsw/commits/wip_attestation_all_2

Jiri Pirko (9):
  attestation: Add the base family specification and generated files
  Documentation: attestation: Add userspace ABI
  attestation: Prepare provider and instance core
  attestation: Prepare measurement registers
  attestation: Add CTLV operation handling
  Documentation: attestation: Describe how to write a provider
  tdx-guest: Expose the native attestation service API
  attestation: Add the TDX family specification and generated files
  attestation: Add the TDX family implementation

 .../ctlv/abi/ctlv-attestation-tdx.yaml        |  21 +
 Documentation/ctlv/abi/ctlv-attestation.yaml  | 147 +++++
 Documentation/ctlv/abi/families.registry.yaml |   2 +
 Documentation/ctlv/families.yaml              |   2 +
 Documentation/ctlv/generated-files.yaml       |  14 +
 .../ctlv/specs/ctlv-attestation-tdx.yaml      |  25 +
 .../ctlv/specs/ctlv-attestation.yaml          | 181 +++++++
 Documentation/driver-api/attestation.rst      |  99 ++++
 Documentation/driver-api/index.rst            |   1 +
 .../userspace-api/attestation-tdx.rst         |  59 +++
 Documentation/userspace-api/attestation.rst   | 294 ++++++++++
 Documentation/userspace-api/index.rst         |   1 +
 Documentation/virt/coco/tdx-guest.rst         |   8 +
 MAINTAINERS                                   |  13 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/attestation/Kconfig                   |  16 +
 drivers/attestation/Makefile                  |   5 +
 drivers/attestation/core/core.c               | 500 ++++++++++++++++++
 drivers/attestation/core/ctlv.c               | 499 +++++++++++++++++
 drivers/attestation/core/internal.h           |  34 ++
 drivers/attestation/core/mr.c                 |  64 +++
 .../generated/ctlv_attestation_gen.c          | 179 +++++++
 .../generated/ctlv_attestation_gen.h          | 204 +++++++
 drivers/virt/coco/tdx-guest/Kconfig           |   4 +-
 drivers/virt/coco/tdx-guest/Makefile          |   6 +
 drivers/virt/coco/tdx-guest/attestation.c     | 313 +++++++++++
 .../coco/tdx-guest/ctlv_attestation_tdx_gen.c |  65 +++
 .../coco/tdx-guest/ctlv_attestation_tdx_gen.h |  44 ++
 drivers/virt/coco/tdx-guest/internal.h        |  48 ++
 .../coco/tdx-guest/{tdx-guest.c => main.c}    | 137 ++++-
 include/linux/attestation.h                   | 243 +++++++++
 include/uapi/ctlv/ctlv_attestation_gen.h      | 234 ++++++++
 include/uapi/ctlv/ctlv_attestation_tdx_gen.h  |  42 ++
 include/uapi/ctlv/ctlv_families_gen.h         |   2 +
 35 files changed, 3480 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/ctlv/abi/ctlv-attestation-tdx.yaml
 create mode 100644 Documentation/ctlv/abi/ctlv-attestation.yaml
 create mode 100644 Documentation/ctlv/specs/ctlv-attestation-tdx.yaml
 create mode 100644 Documentation/ctlv/specs/ctlv-attestation.yaml
 create mode 100644 Documentation/driver-api/attestation.rst
 create mode 100644 Documentation/userspace-api/attestation-tdx.rst
 create mode 100644 Documentation/userspace-api/attestation.rst
 create mode 100644 drivers/attestation/Kconfig
 create mode 100644 drivers/attestation/Makefile
 create mode 100644 drivers/attestation/core/core.c
 create mode 100644 drivers/attestation/core/ctlv.c
 create mode 100644 drivers/attestation/core/internal.h
 create mode 100644 drivers/attestation/core/mr.c
 create mode 100644 drivers/attestation/generated/ctlv_attestation_gen.c
 create mode 100644 drivers/attestation/generated/ctlv_attestation_gen.h
 create mode 100644 drivers/virt/coco/tdx-guest/attestation.c
 create mode 100644 drivers/virt/coco/tdx-guest/ctlv_attestation_tdx_gen.c
 create mode 100644 drivers/virt/coco/tdx-guest/ctlv_attestation_tdx_gen.h
 create mode 100644 drivers/virt/coco/tdx-guest/internal.h
 rename drivers/virt/coco/tdx-guest/{tdx-guest.c => main.c} (79%)
 create mode 100644 include/linux/attestation.h
 create mode 100644 include/uapi/ctlv/ctlv_attestation_gen.h
 create mode 100644 include/uapi/ctlv/ctlv_attestation_tdx_gen.h

-- 
2.56.0

