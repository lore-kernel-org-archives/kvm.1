Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493251;
	b=DFCmo+lgB/0vJJrnFd3+63nDOQxkIT5NH1lOSUPQ6V8niy0oIFDc5cMac2uvPBHU7aHB
	 MHPn+SOOTlCq1yU8ccdDvLLITI3lPCbqc1OFbzEaU8UB1G61D6dbzFpLKNc8hwtcrqJur
	 E89UjF+yh4apOgF/Mv+6gKpU2IcClut4uot7+/H1PG1rOgZvrYaqH4bVySRqLhdjZQiDX
	 tEO4YgO+ZPmjSqq0SDk6ouv2kj6Q//SRX0bJYVEV+7ngEfs65bv+hMcAbVwimHe2n2ybv
	 4PaGqQZQ9SDK5B/7MgdmxOf621Rbx0WHCqWZBhOtSmD58Km63ENRy3uz8NUnCnGT69A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493251;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=ECa+EP2+GWrANsxj0WvwUZJkCIlcvdWbNsc8NiwNlVo=;
	b=wk3EBwAoA80SNxH5E65EvlH6pQHFV+P0p82hCD8ItQg08Be0SJY8MJhqUQ5ikNtlNj++
	 XbzmwBOlBzLJ/qyDTIgfCv9Yg/+UmTB5Kq9BfEvntHwFya3lXyJR5T/tFRwsvvKFdk4K0
	 LpB9oKR0UlCV8Hucos+2QAULPlK5PCUl/ywfZS9EbbAQid6u+010uQxuH2owUGqK3nXuQ
	 FfeWFf5Z0qXQg8h0qc/cEMGC0uKUindZsxx73ZEVG9nB1kh7rqqdFLJxk+pLUtL2/WgtP
	 FF8A1l6kUDVqznIH/evUMRwYsqS8wTpj3HxxalbyzSgYsrtk0pIXScmcbKz0cvqLPpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g5CiGGuN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED9606A32D
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28ED9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g5CiGGuN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECa+EP2+GWrANsxj0WvwUZJkCIlcvdWbNsc8NiwNlVo=;
	b=g5CiGGuNvFD0rgfvjV/dslMMhS8N2Tk2sVawBzi7DbQM0fjPit4aIcWckuDIta3ksgelEp
	5OmtJONQBOz7bKbSzEseUXQFsTZqVjjWpuE8swVjkr/CYFVvHU15f6ssTOzsWVUtWEZsJ8
	ocTQ1UmmJF45kUNLVyBF1gpUAo+Z1T0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330---ICFwzSMLyjVd2-rA4_dw-1; Tue,
 20 Oct 2026 10:47:26 +0000
X-MC-Unique: --ICFwzSMLyjVd2-rA4_dw-1
X-Mimecast-MFC-AGG-ID: --ICFwzSMLyjVd2-rA4_dw_1792493241
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B08BA1955EA9;
	Tue, 20 Oct 2026 10:47:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA0630000E7;
	Tue, 20 Oct 2026 10:47:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:29 +0400
Subject: [PATCH v7 12/65] qapi/qom: add qapi-type field to
 ObjectPropertyInfo
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-12-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iKT89ERqmB5xJit6r3j8WUD6ClpE36oEYsgjEEvZ40o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYxccp5RLblnwypa/9MUPo5yHCT1xWIDSPC
 kA8/nPQHZWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5e/BD/9TtX0u6H+0rpG8WE+dl2QuQTNqc7I7UQsZIGnhPN3Al/XNQZiAz7mmC9G+NYbkf+JSdfB
 k5kprVrQhJ3Qwo46Eo+f3qr8ThczDGZA6O4hzHv5kxdvgp6qn1DaCqqyaCoKsR/z+iuGL2HmZsU
 mDSJqIH3dy3Hb40RluHg7V7GmVv4Rf6FguZ82m5gB7pbbTD2eXnx3z+CnMSeaAmfG4F8BZ0feAi
 ZZdOtwWw3zJcvLJE4/+UfOCPiGxw4cQtY+ATWlNBSjHmmNXNtzG8MlEvUPCJ2Sjn27mHRxuM7nO
 WQ6+yJh/lQ0Ghbdq95AVNza5NuB1EVwplpUXCjM1cH+Yy2DOAZFw8NZuDgRazKKFH/AOAYKwO7P
 fSFGOlRSGjjJuFA4w4sYrs+YXl2zcGOmUVTKNTX3yF2OhQx8UgAnNPV9I4poe0gXiUAgmElaUBX
 bAH8SeScvuf8ZDHbsiN/1WmUdBrI/V4+IxLJlZYGHkeyF8ysSL5DJ7MeUTFBeBmG5LI9nRNWyhj
 xgXX8aohw8Oq+7nyejaTJP4C9/B8IRO6jiFJRRUvMsMjnKfTeEn2904ZPwG2JU6Qdo5st5sHmK6
 GVmZP2Uzs/39Pu485CCHNkrP67konhv+JXIwq2EN4q6gZq+7K1gfG51xtJ2MyHYyCc0BAAGTRD5
 xkTzLUa6kbRI52Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add an optional 'qapi-type' field to ObjectPropertyInfo and
ObjectPropertyValue. When present, it contains the masked type name that
can be looked up in query-qmp-schema output. Absent for properties
without a QAPI type association. Always absent for now, populated
in the following changes.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 49f222796ab4..34be7768135c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -35,6 +35,10 @@
 #        qdev device type name.  Link properties form the device model
 #        graph.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @description: if specified, the description of the property.
 #
 # @default-value: the default value, if any (since 5.0)
@@ -44,6 +48,7 @@
 { 'struct': 'ObjectPropertyInfo',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*description': 'str',
             '*default-value': 'any' } }
 
@@ -55,6 +60,10 @@
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
+# @qapi-type: the name of the property's type as it appears in the
+#     output of ``query-qmp-schema``.  Absent if the type does not
+#     occur there.  (since 11.2)
+#
 # @value: the value of the property.  Absent when the property cannot
 #     be read.
 #
@@ -63,6 +72,7 @@
 { 'struct': 'ObjectPropertyValue',
   'data': { 'name': 'str',
             'type': 'str',
+            '*qapi-type': 'str',
             '*value': 'any' } }
 
 ##

-- 
2.56.0.116.g6de20f6092dc

